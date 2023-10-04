# frozen_string_literal: true

class MoveTransactionTypeToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :category_type, :integer, default: 0
  end
end
