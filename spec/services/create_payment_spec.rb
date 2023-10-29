# frozen_string_literal: true

require 'rails_helper'
require './app/services/create_payment'

RSpec.describe CreatePayment do
  describe '#call' do
    let(:achievement_money_managed)  { create(:achievement, level: :silver, code: :money_managed) }
    let(:achievement_money_movement) { create(:achievement, level: :silver, code: :money_movement) }
    let(:achievement_budget_reached) { create(:achievement, level: :silver, code: :budget_reached) }

    let(:user) do
      create(:user) do |user|
        user.achievements = [achievement_money_managed, achievement_money_movement, achievement_budget_reached]
      end
    end
    let(:account) { create(:account, user_id: user.id, price_cents: 1000) }

    context 'Success scenario' do
      describe 'Paid a recipe' do
        let(:bill_recipe) { create(:bill, user_id: user.id, bill_type: :recipe) }
        let(:transaction_params) do
          attributes_for(:transaction, price_cents: bill_recipe.price_cents, account_id: account.id)
        end
        let(:payment) { CreatePayment.call(user, bill_recipe, transaction_params) }

        it 'validate @payment' do
          expect(payment.valid?).to be_truthy
        end

        it '@payment paid' do
          expect(payment.status).to eq('paid')
        end

        it '@payment should have a new transaction' do
          expect(payment.transactions.count).to eq(1)
        end
      end

      describe 'Paid a expense' do
        let(:bill_expense) { create(:bill, user_id: user.id, bill_type: :expense, price_cents: account.price_cents) }
        let(:transaction_params) do
          attributes_for(:transaction, price_cents: bill_expense.price_cents, account_id: account.id,
                                       move_type: bill_expense.bill_type)
        end
        let(:payment) { CreatePayment.call(user, bill_expense, transaction_params) }

        it '@payment paid' do
          expect(payment.status).to eq('paid')
        end

        it '@payment should have a new transaction' do
          expect(payment.transactions.count).to eq(1)
        end
      end
    end

    context 'Fail scenario' do
      let(:bill_expense) { create(:bill, user_id: user.id, bill_type: :expense, price_cents: 1500) }
      let(:transaction_params) do
        attributes_for(:transaction, price_cents: bill_expense.price_cents,
                                     move_type: bill_expense.bill_type, account_id: account.id)
      end

      describe 'not paid a @payment using account with lower amount' do
        let(:payment) { CreatePayment.call(user, bill_expense, transaction_params) }

        it '@payment pending' do
          expect(payment.status).to eq('pending')
        end

        it '@payment should not have zero transactions' do
          expect(payment.transactions.count).to eq(0)
        end
      end
    end
  end
end
