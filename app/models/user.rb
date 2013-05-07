class User < ActiveRecord::Base
  has_many :texts
  has_many :event

end
