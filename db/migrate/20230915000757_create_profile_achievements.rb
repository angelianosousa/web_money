class CreateProfileAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true
      t.integer :points_reached, null: false, default: 0

      t.timestamps
    end
  end
end
