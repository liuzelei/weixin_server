class Setting < ActiveRecord::Base
  attr_accessible :weixin_id, :token, :welcome_message, :default_message, :user_id

  belongs_to :user

  validates_uniqueness_of :weixin_id
end
