class AddWeixinUserIdToRequestMessages < ActiveRecord::Migration
  def change
    add_column :request_messages, :weixin_user_id, :integer
  end
end
