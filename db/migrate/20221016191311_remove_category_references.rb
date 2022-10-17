class RemoveCategoryReferences < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :move_type, :integer, null: false
  end
end
