class RemovePicUrlAndAddPicToItems < ActiveRecord::Migration
  def up
    add_column :items, :pic, :string
    remove_column :items, :pic_url
  end

  def down
    add_column :items, :pic_url, :string
    remove_column :items, :pic
  end
end
