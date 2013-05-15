class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :description
      t.string :pic_url
      t.string :url

      t.timestamps
    end
  end
end
