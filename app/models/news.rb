class News < ActiveRecord::Base
  attr_accessible :description, :pic_url, :title, :url, :items_attributes

  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true


  validates_presence_of :title, :pic_url#, :description

  # TODO: validate presence of image_url

  #mount_uploader :pic, LocalImageUploader 
  #validates_presence_of :pic, if: Proc.new { |n|
  #  n.new_record?
  #}
end
