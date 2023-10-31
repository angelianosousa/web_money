# frozen_string_literal: true

require 'rails_helper'
require './app/services/transfer_between_accounts'

RSpec.describe TransferBetweenAccounts do
  describe '#call' do
    let(:user) { create(:user) }
    let(:account_in) { create(:account, user_id: user.id, price: 100) }
    let(:account_out) { create(:account, user_id: user.id, price: 100) }

    context 'Success Scenario' do
      describe 'Transfer from account_out to account_in' do
        let(:transfer_params) do
          {
            user: user, price: 100, account_id_in: account_in.id, account_id_out: account_out.id
          }
        end
        let(:transfer) { TransferBetweenAccounts.call(user, transfer_params) }

        it 'transfer should be true' do
          expect(transfer).to be_truthy
          # byebug
          account_in.reload
          account_out.reload

          expect(account_in.transactions.count).to  eq(1)
          expect(account_out.transactions.count).to eq(1)

          expect(account_in.price_cents).to eq(200_00)
          expect(account_out.price_cents).to eq(0)
        end
      end
    end

    context 'Fail Scenario' do
      describe 'when user fill form with same account' do
        let(:transfer_params) do
          {
            user: user, price: 100, account_id_in: account_in.id, account_id_out: account_in.id
          }
        end
        let(:transfer) { TransferBetweenAccounts.call(user, transfer_params) }

        it 'transfer should be false' do
          expect(transfer.errors.any?).to be_truthy

          expect(account_in.transactions.count).to  eq(0)
          expect(account_out.transactions.count).to eq(0)
        end

        it 'user has transfer errors' do
          expect(transfer.errors[:base]).to include I18n.t('accounts.transfer_between_accounts.errors.same_account')
        end
      end

      describe 'when user take off money from account without amount enough' do
        let(:transfer_params) do
          {
            user: user, price: 200_00, account_id_in: account_in.id, account_id_out: account_out.id
          }
        end
        let(:transfer) { TransferBetweenAccounts.call(user, transfer_params) }

        it 'User has transfer errors' do
          message = I18n.t('accounts.transfer_between_accounts.errors.insufficient_amount',
                           account_title: account_out.title)
          expect(transfer.errors[:base]).to include message
        end
      end
    end
  end
end
