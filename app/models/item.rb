class Item < ActiveRecord::Base
  attr_accessible :description, :pic_url, :title, :url, :news_id

  belongs_to :news
end
