class MoveTransactionTypeToCategory < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :move_type, :integer, null: false
    add_column :categories, :category_type, :integer, default: 0
  end
end
