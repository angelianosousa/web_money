# frozen_string_literal: true

class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.string :objective_name
      t.monetize :goals_price, amount: { null: false, default: nil }
      t.datetime :date_limit
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
