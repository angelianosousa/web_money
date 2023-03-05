class ChangeDatetimeForDateOnTransaction < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :date, :date
  end
end
