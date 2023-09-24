# frozen_string_literal: true

class AddUserProfileIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :user_profile, foreign_key: true
  end
end
