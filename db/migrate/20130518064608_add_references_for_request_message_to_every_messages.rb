class AddReferencesForRequestMessageToEveryMessages < ActiveRecord::Migration
  def change
    add_column :wx_texts, :request_message_id, :integer
    add_column :wx_images, :request_message_id, :integer
    add_column :wx_links, :request_message_id, :integer
    add_column :wx_locations, :request_message_id, :integer
    add_column :wx_events, :request_message_id, :integer
  end
end
