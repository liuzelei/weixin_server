class AddMsgTypeToResponseMessages < ActiveRecord::Migration
  def change
    add_column :response_messages, :msg_type, :string
  end
end
