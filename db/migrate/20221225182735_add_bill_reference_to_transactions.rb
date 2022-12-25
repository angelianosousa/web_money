class AddBillReferenceToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :bill, foreign_key: true
  end
end
