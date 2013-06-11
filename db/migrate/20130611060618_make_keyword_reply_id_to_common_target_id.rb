class MakeKeywordReplyIdToCommonTargetId < ActiveRecord::Migration
  def change
    add_column :replies, :target_id, :integer
    add_column :replies, :target_type, :string
  end
end
