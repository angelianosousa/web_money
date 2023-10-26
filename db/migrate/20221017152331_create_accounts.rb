# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :title
      t.monetize :price, amount: { null: false, default: nil }
      t.references :user_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
