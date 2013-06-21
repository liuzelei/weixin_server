class CreateFwBaiduMaps < ActiveRecord::Migration
  def change
    create_table :fw_baidu_maps do |t|
      t.string :title
      t.text :description
      t.string :pic_uuid
      t.string :url

      t.timestamps
    end
  end
end
