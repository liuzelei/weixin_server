class WxLocation < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :scale, :weixin_user_id, :request_message_id
  belongs_to :weixin_user
  belongs_to :request_message

  geocoded_by :geocoding_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
end

