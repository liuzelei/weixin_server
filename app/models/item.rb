class Item < ActiveRecord::Base
  attr_accessible :description, :pic_url, :title, :url, :news_id

  belongs_to :news


  validates_presence_of :title, :pic_url#, :description

  #mount_uploader :pic, LocalImageUploader 
  #validates_presence_of :pic, if: Proc.new { |n|
  #  n.new_record?
  #}
end
