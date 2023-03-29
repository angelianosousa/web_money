class ChangeColumnFromTransaction < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :price_cents, :decimal
    change_column :bills, :price_cents, :decimal
    change_column :accounts, :price_cents, :decimal
  end
end
