class AddColumnsForSettings < ActiveRecord::Migration
  def change
    add_column :settings, :weixin_id, :string
    add_column :settings, :token, :string
    add_column :settings, :welcome_message, :text
    add_column :settings, :default_message, :text

    add_index :settings, :weixin_id, unique: true
  end
end
