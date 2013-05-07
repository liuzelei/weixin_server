class User < ActiveRecord::Base
  has_many :wx_texts
  has_many :event

end
