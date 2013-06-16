class CreateEvents < ActiveRecord::Migration
  def up
    remove_column :events, :weixin_user_id
    remove_column :events, :event

    add_column :events, :category, :string
    add_column :events, :title, :string
    add_column :events, :description, :string
    add_column :events, :pic_uuid, :string
    add_column :events, :url, :string
  end

  def down
    remove_column :events, :category
    remove_column :events, :title
    remove_column :events, :description
    remove_column :events, :pic_uuid
    remove_column :events, :url

    add_column :events, :weixin_user_id, :integer
    add_column :events, :event, :string
  end
end
