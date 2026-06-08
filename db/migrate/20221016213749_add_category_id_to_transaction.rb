# frozen_string_literal: true

class AddCategoryIdToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :category, foreign_key: true
  end
end
