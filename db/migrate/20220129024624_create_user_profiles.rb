# frozen_string_literal: true

class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.string :name, default: ''

      t.timestamps
    end
  end
end
