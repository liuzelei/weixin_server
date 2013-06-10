class RemoveUnusedColumnsFromKeywordReplies < ActiveRecord::Migration
  def up
    remove_column :keyword_replies, :reply_content
    remove_column :keyword_replies, :news_id
    remove_column :keyword_replies, :news_ids
    remove_column :keyword_replies, :coupon
  end

  def down
    add_column :keyword_replies, :reply_content, :text
    add_column :keyword_replies, :news_id, :integer
    add_column :keyword_replies, :news_ids, :string
    add_column :keyword_replies, :coupon, :boolean
  end
end
