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
require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'Validations' do
    subject { build(:transaction, user: create(:user), account: create(:account)) }

    it { is_expected.to belong_to(:user).required }
    it { is_expected.to belong_to(:account).required }
    it { is_expected.to belong_to(:category).optional }
    it { is_expected.to belong_to(:budget).optional }
    it { is_expected.to belong_to(:bill).optional }

    it { is_expected.to validate_presence_of(:price_cents) }
    it { is_expected.to validate_presence_of(:date) }

    it { is_expected.to validate_numericality_of(:price_cents) }
    it { is_expected.to define_enum_for(:move_type) }
  end

  let(:achievement_money_managed)  { create(:achievement, level: :silver, code: :money_managed) }
  let(:achievement_money_movement) { create(:achievement, level: :silver, code: :money_movement) }
  let(:achievement_budget_reached) { create(:achievement, level: :silver, code: :budget_reached) }

  let(:user) do
    create(:user) do |user|
      user.achievements << [achievement_money_managed, achievement_money_movement, achievement_budget_reached]
    end
  end

  let(:account)          { create(:account, price_cents: 1000, user: user) }
  let(:category_recipe)  { create(:category, category_type: :recipe, user: user) }
  let(:category_expense) { create(:category, category_type: :expense, user: user) }

  describe '#save' do
    describe 'Fail scenario' do
      context 'when given invalid attributes' do
        let(:transaction) { build(:transaction, :invalid) }

        it 'should not be valid' do
          expect(transaction.valid?).to be_falsey
          expect(transaction.errors.messages[:account]).to      include 'é obrigatório(a)'
          expect(transaction.errors.messages[:user]).to include 'é obrigatório(a)'
          expect(transaction.errors.messages[:price_cents]).to  include 'não é um número'
          expect(transaction.errors.messages[:price_cents]).to  include 'não pode ficar em branco'
          expect(transaction.errors.messages[:date]).to         include 'não pode ficar em branco'
        end
      end

      context 'when a expense are higher than value in accout' do
        let(:transaction) { build(:transaction, account_id: account.id, move_type: :expense, price_cents: 1001, user_id: user.id) }

        it 'should not be valid' do
          message = I18n.t('activerecord.attributes.errors.models.invalid_movement', account_title: account.title)
          expect(transaction.valid?).to be_falsey
          expect(transaction.errors.messages[:base]).to include message
        end
      end
    end

    describe 'Success scenario' do
      let(:transaction_recipe) { build(:transaction, account_id: account.id, move_type: :recipe, user_id: user.id) }

      context 'Add a new recipe' do
        it 'should be valid' do
          expect(transaction_recipe.valid?).to be_truthy
        end

        it 'should be saved' do
          expect(transaction_recipe.save).to be_truthy
        end
      end

      context 'Add a new expense' do
        let(:transaction_expense) { build(:transaction, account_id: account.id, move_type: :expense, user_id: user.id) }

        it 'should be valid' do
          expect(transaction_expense.valid?).to be_truthy
        end

        it 'should be saved' do
          expect(transaction_expense.save).to be_truthy
        end
      end
    end
  end

  describe '.check_deposit' do
    context 'Success scenario' do
      let(:deposit_transaction) do
        build(:transaction, price_cents: 1000, account: account, move_type: :recipe, category: category_recipe,
                            user: user)
      end

      it 'should save if is a recipe transaction' do
        expect(deposit_transaction.recipe?).to be_truthy
      end

      it 'should have more money in account than before' do
        amount_before = account.price_cents
        deposit_transaction.save
        account.reload
        amount_after = account.price_cents

        expect(amount_after).to satisfy("be greater than #{amount_before}") { |n| n > amount_before }
      end
    end

    context 'Fail scenario' do
      let(:excharge_transaction) do
        build(:transaction, price_cents: 1000, account: account, move_type: :expense, category: category_expense,
                            user: user)
      end

      it 'should not save a expense movement' do
        current_value = account.price_cents
        excharge_transaction.check_deposit
        account.reload

        expect(account.price_cents).to eq(current_value)
      end
    end
  end

  describe '.check_excharge' do
    context 'Fail scenario' do
      let(:transaction) do
        build(:transaction, price_cents: 1001, move_type: :expense, category: category_expense, account: account,
                            user: user)
      end

      it 'excharge are invalid for account with not enough money' do
        excharge_invalid = transaction.expense? && (account.price_cents.to_f < transaction.price_cents.to_f)

        expect(excharge_invalid).to be_truthy
      end

      it 'should not excharge a account that does not have enough money' do
        current_value = account.price_cents
        transaction.check_excharge
        account.reload
        expect(transaction.expense?).to be_truthy
        expect(account.price_cents).to eq(current_value)
      end

      it 'should not save a recipe movement' do
        current_value = account.price_cents
        transaction.check_excharge
        account.reload

        expect(account.price_cents).to eq(current_value)
      end
    end

    context 'Success scenario' do
      let(:transaction) do
        build(:transaction, price_cents: 101, move_type: :expense, category: category_expense, account: account,
                            user: user)
      end

      it 'should save if is a expense transaction' do
        expect(transaction.expense?).to be_truthy
      end

      it 'should have less money in account than before' do
        amount_before = account.price_cents
        transaction.save
        account.reload
        amount_after = account.price_cents

        expect(amount_after).to satisfy("be less than #{amount_before}") { |n| n < amount_before }
      end
    end
  end
end
