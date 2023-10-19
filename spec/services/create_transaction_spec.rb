require 'rails_helper'
require './app/services/create_transaction'

RSpec.describe CreateTransaction do

  describe '#call' do
    let(:user_profile)       { create(:user_profile) }
    let(:account)            { create(:account, user_profile_id: user_profile.id, price_cents: 1000) }
    
    context 'Success scenario' do
      let(:transaction_params) { attributes_for(:transaction, user_profile_id: user_profile.id, account_id: account.id) }
      let(:transaction)        { CreateTransaction.call(user_profile, transaction_params) }

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
        let(:transaction_params) { attributes_for(:transaction, user_profile_id: user_profile.id, account_id: account.id, move_type: :expense) }
        let(:transaction)        { CreateTransaction.call(user_profile, transaction_params) }

        it 'account must be lower amount with expense' do
          amount_account_before = account.price_cents
          transaction.save
          account.reload
          expect(account.price_cents).to be < amount_account_before
        end
      end

    end

    context 'Fail scenario' do
      let(:transaction_params) { attributes_for(:transaction, account_id: account.id, price_cents: nil, date: nil, user_profile_id: nil) }
      let(:transaction)        { CreateTransaction.call(user_profile, transaction_params) }

      describe 'when given invalid transaction params' do
        
        it 'should not be valid' do
          expect(transaction.valid?).to be_falsey
          # expect(transaction.errors.messages[:account]).to      include 'é obrigatório(a)'
          expect(transaction.errors.messages[:user_profile]).to include 'é obrigatório(a)'
          expect(transaction.errors.messages[:price_cents]).to  include 'não é um número'
          expect(transaction.errors.messages[:price_cents]).to  include 'não pode ficar em branco'
          expect(transaction.errors.messages[:date]).to         include 'não pode ficar em branco'
        end

        it 'should not save' do
          expect(transaction.save).to be_falsey
        end
      end
    end
  end
end
