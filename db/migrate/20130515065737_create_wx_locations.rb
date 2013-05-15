class CreateWxLocations < ActiveRecord::Migration
  def change
    create_table :wx_locations do |t|
      t.references :weixin_user
      t.string :location_x
      t.string :location_y
      t.integer :scale
      t.timestamps
    end
  end
end
