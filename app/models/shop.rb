class Shop < ActiveRecord::Base
  attr_accessible :region, :address, :name, :phone_number, :latitude, :longitude, :geocoding_address

  geocoded_by :geocoding_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
end
