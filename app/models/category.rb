# == Schema Information
#
# Table name: categories
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  user_profile_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_type   :integer          default("recipe")
#
class Category < ApplicationRecord
  enum category_type: %i(recipe expense)

  has_many :transactions, dependent: :destroy
  belongs_to :user_profile

  validates :title, presence: true, uniqueness: { case_sensitive: true }

  scope :recipes, ->(){
    where(category_type: :recipe).includes(:transactions)
  }

  scope :expenses, ->(){
    where(category_type: :expense).includes(:transactions)
  }
end
