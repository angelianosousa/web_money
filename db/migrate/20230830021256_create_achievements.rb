class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.references :user_profile, null: false, foreign_key: true
      t.string :description
      t.integer :code
      t.jsonb :goal
      t.integer :reached

      t.timestamps
    end
  end
end
