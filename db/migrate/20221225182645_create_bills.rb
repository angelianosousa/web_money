# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :title
      t.decimal :price_cents, amount: { null: false, default: nil }
      t.date :due_pay
      t.integer :bill_type
      t.integer :status, default: 0 # Pending
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
