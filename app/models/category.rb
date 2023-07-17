# == Schema Information
#
# Table name: categories
#
#  id              :bigint           not null, primary key
#  category_type   :integer          default("recipe")
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#
# Indexes
#
#  index_categories_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Category < ApplicationRecord
  enum category_type: %i[recipe expense]

  belongs_to :user_profile
  has_many :transactions, dependent: :destroy

  validates :title, uniqueness: { scope: :user_profile_id }

  scope :recipes, ->(){
    where(category_type: :recipe).includes(:transactions)
  }

  scope :expenses, ->(){
    where(category_type: :expense).includes(:transactions)
  }
end
