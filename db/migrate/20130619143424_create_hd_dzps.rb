class CreateHdDzps < ActiveRecord::Migration
  def change
    create_table :hd_dzps do |t|
      t.string :title
      t.text :description
      t.string :pic_uuid
      t.string :url

      t.timestamps
    end
  end
end
