class CreateRecurrences < ActiveRecord::Migration[5.2]
  def change
    create_table :recurrences do |t|
      t.references :user_profile, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title
      t.monetize :price, default: 1.00
      t.boolean :pay, default: false
      t.datetime :date_expire, null: false

      t.timestamps
    end
  end
end
