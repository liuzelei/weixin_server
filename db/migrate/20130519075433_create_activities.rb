class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :title
      t.text :description
      t.string :url
      t.string :pic
      t.string :keyword

      t.timestamps
    end
  end
end
