class CreateReplyTexts < ActiveRecord::Migration
  def change
    create_table :reply_texts do |t|
      t.text :content

      t.timestamps
    end
  end
end
