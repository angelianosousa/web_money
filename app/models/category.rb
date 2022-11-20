# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  enum category_type: %i(recipe expense)

  has_many :transactions, dependent: :destroy
  belongs_to :user_profile
end
