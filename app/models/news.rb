class News < ActiveRecord::Base
  attr_accessible :description, :pic_url, :title, :url

  has_many :items
end
