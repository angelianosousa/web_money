class CreateRecurrences < ActiveRecord::Migration[5.2]
  def change
    create_table :recurrences do |t|
      t.references :user_profile, foreign_key: true
      t.string :category
      t.string :title
      t.decimal :value
      t.boolean :pay, default: false
      t.datetime :date_expire

      t.timestamps
    end
  end
end
