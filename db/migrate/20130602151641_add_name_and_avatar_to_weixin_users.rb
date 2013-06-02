class AddNameAndAvatarToWeixinUsers < ActiveRecord::Migration
  def change
    add_column :weixin_users, :name, :string
    add_column :weixin_users, :avatar, :string
  end
end
