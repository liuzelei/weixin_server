class Item < ActiveRecord::Base
  attr_accessible :description, :pic, :title, :url, :news_id

  belongs_to :news

  mount_uploader :pic, LocalImageUploader 

  validates_presence_of :title, :pic, :url, :description
end
