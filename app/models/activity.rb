class Activity < ActiveRecord::Base
  attr_accessible :description, :keyword, :name, :pic, :title, :url

  mount_uploader :pic, LocalImageUploader

  has_many :replies, as: :replying, dependent: :destroy
  has_one :ownership, as: :item, dependent: :destroy

  validates_presence_of :title, :name, :keyword

  validates_presence_of :pic, if: Proc.new { |n|
    n.new_record?
  }
end
