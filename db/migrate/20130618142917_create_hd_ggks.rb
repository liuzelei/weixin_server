class CreateHdGgks < ActiveRecord::Migration
  def change
    create_table :hd_ggks do |t|
      t.string :title
      t.text :description
      t.string :pic_uuid
      t.string :url
      t.integer :max_random
      t.integer :max_luck

      t.timestamps
    end
  end
end
