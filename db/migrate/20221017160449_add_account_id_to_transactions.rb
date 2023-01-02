class AddAccountIdToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :account, foreign_key: true
    add_column :transactions, :description, :text, default: nil
    remove_column :transactions, :title, :string
  end
end
