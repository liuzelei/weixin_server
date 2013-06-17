class DeleteUnusedColumnsForReplies < ActiveRecord::Migration
  def up
    remove_column :replies, :keyword_reply_id
  end

  def down
    add_column :replies, :keyword_reply_id, :integer
  end
end
