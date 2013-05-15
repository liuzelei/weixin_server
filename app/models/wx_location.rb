class WxLocation < ActiveRecord::Base
  attr_accessible :location_x, :location_y, :scale, :weixin_user_id
  belongs_to :weixin_user

end

