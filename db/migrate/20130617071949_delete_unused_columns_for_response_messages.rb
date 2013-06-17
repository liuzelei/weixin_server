class DeleteUnusedColumnsForResponseMessages < ActiveRecord::Migration
  def up
    remove_column :response_messages, :content
    remove_column :response_messages, :news_id
    remove_column :response_messages, :msg_type
  end

  def down
    add_column :response_messages, :content, :text
    add_column :response_messages, :news_id, :integer
    add_column :response_messages, :msg_type, :string
  end
end
