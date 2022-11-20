class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :title
      t.monetize :price, default: 1.00
      t.datetime :date

      t.timestamps
    end
  end
end
