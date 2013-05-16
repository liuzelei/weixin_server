class News < ActiveRecord::Base
  attr_accessible :description, :pic, :title, :url

  has_many :items

  mount_uploader :pic, LocalImageUploader 

  validates_presence_of :title, :pic_url, :url, :description
end
