class RenameUserIdToWeixinUserIdForAllTables < ActiveRecord::Migration
  def change
    rename_column :events, :user_id, :weixin_user_id
    rename_column :response_messages, :user_id, :weixin_user_id
    rename_column :wx_texts, :user_id, :weixin_user_id
  end
end
