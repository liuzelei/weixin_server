class ChageWeixinUsersGeocodingInfoColumnFormat < ActiveRecord::Migration
  def up
    remove_column :weixin_users, :latitude
    add_column :weixin_users, :latitude, :float
    remove_column :weixin_users, :longitude
    add_column :weixin_users, :longitude, :float
  end

  def down
    remove_column :weixin_users, :latitude
    add_column :weixin_users, :latitude, :string
    remove_column :weixin_users, :longitude
    add_column :weixin_users, :longitude, :string
  end
end
