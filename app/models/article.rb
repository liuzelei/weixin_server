class Article < ActiveRecord::Base
  attr_accessible :content, :title

  has_one :ownership, as: :item, dependent: :destroy
  validates_presence_of :content
end
