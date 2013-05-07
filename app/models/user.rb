class User < ActiveRecord::Base
  attr_accessible :open_id

  has_many :wx_texts
  has_many :event

end
