class ChangeWeixinUserAddressFormat < ActiveRecord::Migration
  def up
    remove_column :weixin_users, :address
    add_column :weixin_users, :location_x, :string
    add_column :weixin_users, :location_y, :string
    add_column :weixin_users, :scale, :string
  end

  def down
    remove_column :weixin_users, :location_x
    remove_column :weixin_users, :location_y
    remove_column :weixin_users, :scale
    dd_column :weixin_users, :address, :string
  end
end
