class DeleteUnusedColumnsForSettings < ActiveRecord::Migration
  def up
    remove_column :settings, :name
    remove_column :settings, :content
  end

  def down
    add_column :settings, :name, :string
    add_column :settings, :content, :text
  end
end
