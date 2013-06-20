class Hd::DzpHistory < ActiveRecord::Base
  attr_accessible :dzp_id, :prize, :sn_code, :status, :used_at, :weixin_user_id

  belongs_to :dzp, class_name: "Hd::Dzp"
end
