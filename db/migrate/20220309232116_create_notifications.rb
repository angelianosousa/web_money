class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user_profile, foreign_key: true
      t.string :title
      t.string :description
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
