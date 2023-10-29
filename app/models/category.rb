# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_type :integer          default("recipe"), not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord
  enum category_type: %i[recipe expense]

  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :user_id }

  scope :recipes, -> { where(category_type: :recipe).includes(:transactions) }

  scope :expenses, -> { where(category_type: :expense).includes(:transactions) }

  def recipe?
    category_type == 'recipe'
  end

  def expense?
    category_type == 'expense'
  end
end
