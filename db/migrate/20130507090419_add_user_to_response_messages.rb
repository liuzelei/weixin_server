class AddUserToResponseMessages < ActiveRecord::Migration
  def change
    add_column :response_messages, :user_id, :integer
  end
end
