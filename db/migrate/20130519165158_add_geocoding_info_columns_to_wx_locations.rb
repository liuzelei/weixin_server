class AddGeocodingInfoColumnsToWxLocations < ActiveRecord::Migration
  def up
    remove_column :wx_locations, :location_x
    add_column :wx_locations, :latitude, :float
    remove_column :wx_locations, :location_y
    add_column :wx_locations, :longitude, :float

    add_column :wx_locations, :geocoding_address, :string
  end

  def down
    remove_column :wx_locations, :latitude
    add_column :wx_locations, :location_x, :string
    remove_column :wx_locations, :longitude
    add_column :wx_locations, :location_y, :string

    remove_column :wx_locations, :geocoding_address
  end
end
