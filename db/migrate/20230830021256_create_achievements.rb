class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.string :description
      t.integer :code
      t.integer :points
      t.integer :level, default: 1

      t.timestamps
    end
  end
end
