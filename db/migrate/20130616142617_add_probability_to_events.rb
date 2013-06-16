class AddProbabilityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_random, :integer
    add_column :events, :max_luck, :integer
  end
end
