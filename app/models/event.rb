class Event < ActiveRecord::Base
  attr_accessible :event, :weixin_user_id
  belongs_to :weixin_user

end
