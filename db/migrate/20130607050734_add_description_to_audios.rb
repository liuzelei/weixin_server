class AddDescriptionToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :description, :text
  end
end
