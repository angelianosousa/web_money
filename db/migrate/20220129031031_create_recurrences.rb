class CreateRecurrences < ActiveRecord::Migration[5.2]
  def change
    create_table :recurrences do |t|
      t.references :user_profile, foreign_key: true
      t.string :title
      t.monetize :price, default: 1.00
      t.boolean :pay, default: false

      t.timestamps
    end
  end
end
