class CreateOwnership < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.references :user
      t.references :item, polymorphic: true

      t.timestamps
    end
  end
end
