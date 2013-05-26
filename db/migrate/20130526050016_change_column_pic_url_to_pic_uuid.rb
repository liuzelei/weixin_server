class ChangeColumnPicUrlToPicUuid < ActiveRecord::Migration
  def change
    rename_column :news, :pic_url, :pic_uuid
    rename_column :items, :pic_url, :pic_uuid
  end
end
