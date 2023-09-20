# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :title
      t.monetize :price
      t.datetime :date

      t.timestamps
    end
  end
end
