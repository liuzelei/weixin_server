class Shop < ActiveRecord::Base
  attr_accessible :region, :address, :name, :phone_number, :latitude, :longitude, :geocoding_address
end
