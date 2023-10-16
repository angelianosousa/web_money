# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  date            :date
#  description     :text
#  move_type       :integer          default("recipe"), not null
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  bill_id         :bigint
#  budget_id       :bigint
#  category_id     :bigint
#  user_profile_id :bigint
#
# Indexes
#
#  index_transactions_on_account_id       (account_id)
#  index_transactions_on_bill_id          (bill_id)
#  index_transactions_on_budget_id        (budget_id)
#  index_transactions_on_category_id      (category_id)
#  index_transactions_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (bill_id => bills.id)
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Transaction < ApplicationRecord
  enum move_type: %i[recipe expense transfer]

  # Record Relations
  belongs_to :account
  belongs_to :user_profile
  belongs_to :category, optional: true
  belongs_to :bill, optional: true
  belongs_to :budget, optional: true

  # Money Rails
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :date, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 1 }

  # Callbacks
  after_save :check_deposit
  after_save :check_excharge
  after_save :count_points

  paginates_per 7

  def check_deposit
    return unless recipe?

    account.price_cents += price_cents.to_f
    account.save
  end

  def check_excharge
    return unless expense?

    account.price_cents -= price_cents.to_f
    account.save
  end

  def expense_or_recipe_calc
    account.price_cents -= price_cents if category.recipe?
    account.price_cents += price_cents if category.expense?
  end

  def count_points
    return unless new_record? || transfer_between_account?

    CountAchievePoints.call(user_profile, :money_movement)
    CountAchievePoints.call(user_profile, :money_managed)
    CountAchievePoints.call(user_profile, :budget_reached) if budget.present?
  end

  def transfer_between_account?
    category_id == nil
  end

  # scope :recipes, lambda {
  #   # where(category_id: Category.where(category_type: :recipe)).includes(:account, :category)
  #   where(move_type: :recipe).includes(:account, :category)
  # }

  scope :recipes, -> { where(move_type: :recipe).includes(:account, :category) }
  scope :expenses, -> { where(move_type: :expense).includes(:account, :category) }

  # scope :expenses, lambda {
  #   where(move_type: :expense).includes(:account, :category)

  #   # where(category_id: Category.where(category_type: :expense)).includes(:account, :category)
  # }

end
