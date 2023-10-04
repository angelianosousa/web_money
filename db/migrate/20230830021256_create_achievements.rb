class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.string :icon
      t.string :description
      t.integer :code
      t.integer :total_points
      t.integer :level, default: 1
      t.integer :points_reached, default: 0

      t.timestamps
    end
  end
end
