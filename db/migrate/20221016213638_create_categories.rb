class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.references :user_profile, foreign_key: true

      t.timestamps
    end
  end
end
