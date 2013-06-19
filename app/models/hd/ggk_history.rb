class Hd::GgkHistory < ActiveRecord::Base
  attr_accessible :prize, :sn_code, :status, :used_at, :weixin_user_id

  belongs_to :ggk, class_name: "Hd::Ggk"
end
