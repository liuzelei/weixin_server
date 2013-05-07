class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :weixin_id, :string
    add_column :users, :sex, :boolean
    add_column :users, :age, :string
    add_column :users, :address, :string
  end
end
