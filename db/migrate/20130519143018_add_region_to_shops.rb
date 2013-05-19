class AddRegionToShops < ActiveRecord::Migration
  def change
    add_column :shops, :region, :string
  end
end
