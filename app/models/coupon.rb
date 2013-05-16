class Coupon < ActiveRecord::Base
  attr_accessible :expired_at, :sn_code, :status, :used_at
end
