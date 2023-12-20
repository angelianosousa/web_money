# frozen_string_literal: true

class AddBudgetReferencesToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :budget, foreign_key: true
  end
end
