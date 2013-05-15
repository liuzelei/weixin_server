class News < ActiveRecord::Base
  attr_accessible :description, :pic_url, :title, :url

  has_many :items

  validates_presence_of :title, :pic_url, :url, :description
end
