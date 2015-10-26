class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :goal_text, null: false
      t.integer :user_id, null: false, index: true
      t.boolean :completed, default: false
      t.boolean :private, default: true

      t.timestamps null: false
    end
  end
end
