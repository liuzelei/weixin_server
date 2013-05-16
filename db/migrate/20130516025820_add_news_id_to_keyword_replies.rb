class AddNewsIdToKeywordReplies < ActiveRecord::Migration
  def change
    add_column :keyword_replies, :news_id, :integer
  end
end
