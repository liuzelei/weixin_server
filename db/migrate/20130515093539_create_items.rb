class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :news
      t.string :title
      t.text :description
      t.string :pic_url
      t.string :url

      t.timestamps
    end
  end
end
