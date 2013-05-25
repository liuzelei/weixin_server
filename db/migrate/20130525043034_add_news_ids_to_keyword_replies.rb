class AddNewsIdsToKeywordReplies < ActiveRecord::Migration
  def change
    add_column :keyword_replies, :news_ids, :string
  end
end
