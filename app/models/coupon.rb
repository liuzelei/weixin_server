class Coupon < ActiveRecord::Base
  attr_accessible :expired_at, :sn_code, :status, :used_at, :weixin_user_id

  belongs_to :weixin_user
end
