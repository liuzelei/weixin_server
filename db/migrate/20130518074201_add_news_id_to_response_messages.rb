class AddNewsIdToResponseMessages < ActiveRecord::Migration
  def change
    add_column :response_messages, :news_id, :integer
  end
end
