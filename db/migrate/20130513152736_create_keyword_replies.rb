class CreateKeywordReplies < ActiveRecord::Migration
  def change
    create_table :keyword_replies do |t|
      t.string :keyword
      t.text :reply_content

      t.timestamps
    end
  end
end
