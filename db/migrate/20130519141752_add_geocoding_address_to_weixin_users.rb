class AddGeocodingAddressToWeixinUsers < ActiveRecord::Migration
  def change
    add_column :weixin_users, :geocoding_address, :string
  end
end
