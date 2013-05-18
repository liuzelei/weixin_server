class AddMsgTypeToRequestMessages < ActiveRecord::Migration
  def change
    add_column :request_messages, :msg_type, :string
  end
end
