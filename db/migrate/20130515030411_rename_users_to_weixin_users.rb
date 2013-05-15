class RenameUsersToWeixinUsers < ActiveRecord::Migration
  def change
    rename_table :users, :weixin_users
  end
end
