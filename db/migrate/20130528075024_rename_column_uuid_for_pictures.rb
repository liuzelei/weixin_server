class RenameColumnUuidForPictures < ActiveRecord::Migration
  def change
    rename_column :pictures, :uuid, :pic_uuid
  end
end
