class AddCouponIdToKeywordReplies < ActiveRecord::Migration
  def change
    add_column :keyword_replies, :coupon, :boolean
  end
end
