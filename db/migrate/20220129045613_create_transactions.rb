# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :title
      t.monetize :price, amount: { null: false, default: nil }
      t.datetime :date
      t.integer :move_type, null: false, default: 0

      t.timestamps
    end
  end
end
