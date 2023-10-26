# frozen_string_literal: true

require 'rails_helper'
require './app/services/create_transaction'

RSpec.describe CreateTransaction do
  describe '#call' do
    let(:user)    { create(:user) }
    let(:account) { create(:account, user_id: user.id, price_cents: 1000) }

    context 'Success scenario' do
      let(:transaction_params) do
        attributes_for(:transaction, user_id: user.id, account_id: account.id)
      end
      let(:transaction) { CreateTransaction.call(user, transaction_params) }

      it 'validate @transaction' do
        expect(transaction.valid?).to be_truthy
      end

      it 'save transaction' do
        expect(transaction.save).to be_truthy
      end

      it 'account must be higher amount with recipe' do
        amount_account_before = account.price_cents
        transaction.save
        account.reload
        expect(account.price_cents).to be > amount_account_before
      end

      describe 'create a transaction expense' do
        let(:transaction_params) do
          attributes_for(:transaction, user_id: user.id, account_id: account.id, move_type: :expense)
        end
        let(:transaction) { CreateTransaction.call(user, transaction_params) }

        it 'account must be lower amount with expense' do
          amount_account_before = account.price_cents
          transaction.save
          account.reload
          expect(account.price_cents).to be < amount_account_before
        end
      end
    end

    context 'Fail scenario' do
      let(:transaction_params) do
        attributes_for(:transaction, account_id: account.id, price_cents: nil, date: nil, user_id: nil)
      end
      let(:transaction) { CreateTransaction.call(user, transaction_params) }

      describe 'when given invalid transaction params' do
        it 'should not be valid' do
          expect(transaction.valid?).to be_falsey
          expect(transaction.errors.messages[:price_cents]).to include 'não é um número', 'não pode ficar em branco'
          # expect(transaction.errors.messages[:date]).to         include 'não pode ficar em branco'
        end

        it 'should not save' do
          expect(transaction.save).to be_falsey
        end
      end
    end
  end
end
