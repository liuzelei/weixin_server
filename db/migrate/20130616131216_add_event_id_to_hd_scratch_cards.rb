class AddEventIdToHdScratchCards < ActiveRecord::Migration
  def change
    add_column :hd_scratch_cards, :event_id, :integer
  end
end
