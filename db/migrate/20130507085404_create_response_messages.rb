class CreateResponseMessages < ActiveRecord::Migration
  def change
    create_table :response_messages do |t|
      t.text :content

      t.timestamps
    end
  end
end
