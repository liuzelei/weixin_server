class AddPicUrlToItems < ActiveRecord::Migration
  def change
    add_column :items, :pic_url, :string
  end
end
