class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.references :weixin_user
      t.string :sn_code
      t.string :status
      t.datetime :expired_at
      t.datetime :used_at

      t.timestamps
    end
  end
end
