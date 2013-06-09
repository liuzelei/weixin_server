class ChangeColumnNameForReplies < ActiveRecord::Migration
  def change
    rename_column :replies, :replying_id, :item_id
    rename_column :replies, :replying_type, :item_type
  end
end
