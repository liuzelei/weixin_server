class AddPicToNews < ActiveRecord::Migration
  def up
    add_column :news, :pic, :string
    remove_column :news, :pic_url
  end

  def down
    add_column :news, :pic_url, :string
    remove_column :news, :pic
  end
end

