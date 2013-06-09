# encoding: utf-8
class Ownership < ActiveRecord::Base
  attr_accessible :user_id, :item_id, :item_type

  belongs_to :user
  belongs_to :item, polymorphic: true, :primary_key => :id


  validates_presence_of :item_id, :item_type

end

