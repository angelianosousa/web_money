class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :recurrence, foreign_key: true
      t.string :title
      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
