class CreateUsersAndEventsAndTexts < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :open_id
      t.timestamps
    end

    create_table :wx_texts do |t|
      t.references :user
      t.string :content
      t.timestamps
    end

    create_table :events do |t|
      t.references :user
      t.string :event
      t.timestamps
    end
  end
end
