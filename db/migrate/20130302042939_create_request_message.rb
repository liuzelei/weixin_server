class CreateRequestMessage < ActiveRecord::Migration
  def up
    create_table :request_messages do |t|
      t.text :xml

      t.timestamps
    end
  end

  def down
    drop_table :request_messages
  end
end
