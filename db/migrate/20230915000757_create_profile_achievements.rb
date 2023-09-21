class CreateProfileAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_achievements do |t|
      t.references :user_profile, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
