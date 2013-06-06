class CreateReplyings < ActiveRecord::Migration
  def change
    create_table :replyings do |t|
      t.integer :keyword_reply_id
      t.integer :reply_id
      t.string  :reply_type

      t.timestamps
    end
  end
end
