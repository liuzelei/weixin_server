class AddAccountAndPasswordToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :account, :string
    add_column :settings, :password, :string
  end
end
