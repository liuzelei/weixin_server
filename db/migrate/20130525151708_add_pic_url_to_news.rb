class AddPicUrlToNews < ActiveRecord::Migration
  def change
    add_column :news, :pic_url, :string
  end
end
