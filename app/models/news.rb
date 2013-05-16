class News < ActiveRecord::Base
  attr_accessible :description, :pic, :title, :url, :items_attributes

  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true

  mount_uploader :pic, LocalImageUploader 

  validates_presence_of :title, :pic, :url, :description
end
