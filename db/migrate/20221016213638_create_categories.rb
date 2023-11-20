# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :category_type, null: false, default: 0

      t.timestamps
    end
  end
end
