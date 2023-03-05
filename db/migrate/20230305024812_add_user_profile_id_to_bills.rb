class AddUserProfileIdToBills < ActiveRecord::Migration[6.0]
  def change
    add_reference :bills, :user_profile, null: false, foreign_key: true
  end
end
