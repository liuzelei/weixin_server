class Hd::ScratchCard < ActiveRecord::Base
  attr_accessible :prize, :sn_code, :status, :used_at, :weixin_user_id, :event_id

  belongs_to :event, class_name: "Event"
  belongs_to :weixin_user, class_name: "WeixinUser"

  has_one :ownership, as: :item, dependent: :destroy
end
