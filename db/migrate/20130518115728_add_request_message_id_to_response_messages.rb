class AddRequestMessageIdToResponseMessages < ActiveRecord::Migration
  def change
    add_column :response_messages, :request_message_id, :integer
  end
end
