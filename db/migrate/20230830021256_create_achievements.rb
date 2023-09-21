class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.string :icon
      t.string :description
      t.integer :code
      t.jsonb :goal
      t.integer :reached, default: 0

      t.timestamps
    end
  end
end
