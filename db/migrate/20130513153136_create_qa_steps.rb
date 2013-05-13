class CreateQaSteps < ActiveRecord::Migration
  def change
    create_table :qa_steps do |t|
      t.string :keyword
      t.text :question
      t.integer :priority

      t.timestamps
    end
  end
end
