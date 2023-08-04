class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.datetime :date_limit
      t.references :user_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
