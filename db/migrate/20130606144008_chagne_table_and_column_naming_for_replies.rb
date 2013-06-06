class ChagneTableAndColumnNamingForReplies < ActiveRecord::Migration
  def change
    rename_table :replyings, :replies
    rename_column :replies, :reply_id, :replying_id
    rename_column :replies, :reply_type, :replying_type
  end
end
