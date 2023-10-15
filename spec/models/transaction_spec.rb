# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  date            :date
#  description     :text
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  bill_id         :bigint
#  budget_id       :bigint
#  category_id     :bigint           not null
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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Validations' do
    it { is_expected.to belong_to(:user_profile).required }
    it { is_expected.to belong_to(:account).required }
    it { is_expected.to belong_to(:category).required }
    it { is_expected.to belong_to(:budget).optional }
    it { is_expected.to belong_to(:bill).optional }

    it { is_expected.to validate_presence_of(:price_cents) }
    it { is_expected.to validate_presence_of(:date) }

    it { is_expected.to validate_numericality_of(:price_cents) }
  end

  let(:user_profile) { create(:user_profile) }
  let(:transaction)  { build(:transaction) }

  describe '#save' do
    context 'when price_cents is empty' do
      let(:transaction) { build(:transaction, price_cents: nil, date: nil) }

      it 'should not be valid' do
        expect(transaction.valid?).to be_falsey
      end
    end

    context 'when title is full' do
      it 'should be valid' do
        expect(transaction.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(transaction.save).to be_truthy
      end
    end

    context 'presence of account' do
      let(:transaction_without_account) { build(:transaction, account_id: 0) }

      it 'when account not exists' do
        account = Account.find_by(id: transaction_without_account.account_id)

        expect(account.present?).to be_falsey
      end

      it 'when account exists' do
        account = Account.find(transaction.account_id)

        expect(account.present?).to be_truthy
      end
    end
  end

  context '.check_deposit' do
    let(:account)             { create(:account, price_cents: 1000, user_profile: user_profile) }
    let(:category_recipe)     { create(:category, category_type: :recipe, user_profile: user_profile) }
    let(:deposit_transaction) do
      build(:transaction, price_cents: 1000, account: account, category: category_recipe, user_profile: user_profile)
    end

    it 'should save if is a recipe transaction' do
      expect(deposit_transaction.category.recipe?).to be_truthy
    end

    it 'should have more money in account than before' do
      amount_before = account.price_cents
      deposit_transaction.save
      account.reload
      amount_after = account.price_cents

      expect(amount_after).to satisfy("be greater than #{amount_before}") { |n| n > amount_before }
    end
  end

  context '.check_excharge' do
    let(:account)          { create(:account, price_cents: 1000, user_profile: user_profile) }
    let(:category_expense) { create(:category, category_type: :expense, user_profile: user_profile) }

    let(:excharge_account) do
      build(:transaction, price_cents: 101, category: category_expense, account: account, user_profile: user_profile)
    end

    it 'should save if is a expense transaction' do
      expect(excharge_account.category.expense?).to be_truthy
    end

    it 'should have less money in account than before' do
      amount_before = account.price_cents
      excharge_account.save
      account.reload
      amount_after = account.price_cents

      expect(amount_after).to satisfy("be less than #{amount_before}") { |n| n < amount_before }
    end

    let(:not_excharge_account) do
      build(:transaction, price_cents: 1001, category: category_expense, account: account, user_profile: user_profile)
    end

    it 'should not excharge a account that does not have enough money' do
      excharge_invalid = not_excharge_account.category.expense? &&
                         (account.price_cents.to_f < not_excharge_account.price_cents.to_f)

      expect(excharge_invalid).to be_truthy
    end
  end

end
