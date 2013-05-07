class User < ActiveRecord::Base
  attr_accessible :open_id, :weixin_id, :sex, :age, :address

  has_many :wx_texts
  has_many :event

end
