class CreateHdGgkHistories < ActiveRecord::Migration
  def change
    create_table :hd_ggk_histories do |t|
      t.integer :weixin_user_id
      t.string :sn_code
      t.string :status
      t.datetime :used_at
      t.string :prize
      t.references :ggk

      t.timestamps
    end
  end
end
