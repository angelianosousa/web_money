# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id             :bigint           not null, primary key
#  date           :date
#  description    :text
#  move_type      :integer          default("recipe"), not null
#  price_cents    :integer          not null
#  price_currency :string           default("BRL"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint
#  bill_id        :bigint
#  budget_id      :bigint
#  category_id    :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_transactions_on_account_id   (account_id)
#  index_transactions_on_bill_id      (bill_id)
#  index_transactions_on_budget_id    (budget_id)
#  index_transactions_on_category_id  (category_id)
#  index_transactions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (bill_id => bills.id)
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Transaction < ApplicationRecord
  enum move_type: %i[recipe expense transfer]

  # Record Relations
  belongs_to :account
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :bill, optional: true
  belongs_to :budget, optional: true

  # Money Rails
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :date, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validate :validate_expense, if: :excharge_valid?
  validates :account_id, presence: true

  # Callbacks
  after_save :check_deposit
  after_save :check_excharge
  after_save :count_points
  before_validation :set_description_for_transfer

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

  # TODO: | E se a transação for uma transferência entre contas ?
  def expense_or_recipe_calc
    check_excharge if recipe? && category&.recipe?
    check_deposit  if expense? && category&.expense?
  end

  private

  def count_points
    return if transfer_between_account?

    CountAchievePoints.call(user, :money_movement)
    CountAchievePoints.call(user, :money_managed)
    CountAchievePoints.call(user, :budget_reached) if budget.present?
  end

  def transfer_between_account?
    category_id.nil? && transfer?
  end

  def set_description_for_transfer
    return unless transfer_between_account?

    self.description = 'Transferência entre contas'
  end

  def excharge_valid?
    return if recipe? || transfer? || account.nil?

    account.price_cents < price_cents.to_f
  end

  # Must be error if are recipe or are expense value is higher that account amount
  def validate_expense
    message = I18n.t('activerecord.attributes.errors.models.invalid_movement', account_title: account.title)
    errors.add :base, :invalid, message: message
  end

  scope :recipes, ->  { where(move_type: :recipe).includes(:account, :category) }
  scope :expenses, -> { where(move_type: :expense).includes(:account, :category) }
end
