class Article < ActiveRecord::Base
  attr_accessible :content, :title

  validates_presence_of :content
end
