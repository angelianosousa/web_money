class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :title
      t.decimal :price_cents
      t.date :due_pay
      t.integer :bill_type
      t.integer :status, default: 0 # Pending

      t.timestamps
    end
  end
end
