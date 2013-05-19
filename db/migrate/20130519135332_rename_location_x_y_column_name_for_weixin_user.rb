class RenameLocationXYColumnNameForWeixinUser < ActiveRecord::Migration
  def change
    rename_column :weixin_users, :location_x, :latitude
    rename_column :weixin_users, :location_y, :longitude
  end
end
