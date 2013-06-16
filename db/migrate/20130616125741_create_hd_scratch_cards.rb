class CreateHdScratchCards < ActiveRecord::Migration
  def change
    create_table :hd_scratch_cards do |t|
      t.integer :weixin_user_id
      t.string :sn_code
      t.string :status
      t.datetime :used_at
      t.string :prize

      t.timestamps
    end
  end
end
