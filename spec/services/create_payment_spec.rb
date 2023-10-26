# frozen_string_literal: true

require 'rails_helper'
require './app/services/create_payment'

RSpec.describe CreatePayment do
  describe '#call' do
    let(:user_profile) { create(:user_profile) }
    let(:account) { create(:account, user_profile_id: user_profile.id) }
    let(:bill) { create(:bill, user_profile_id: user_profile.id) }
    let(:transaction_params) do
      attributes_for(:transaction, price_cents: bill.price_cents, account_id: account.id)
    end

    context 'Success scenario' do
      let(:payment) { CreatePayment.call(user_profile, bill, transaction_params) }

      it 'validate @payment' do
        expect(payment.valid?).to be_truthy
      end

      it '@payment paid' do
        expect(payment.status).to eq('paid')
      end

      it '@payment with valid integral transaction' do
        expect(payment.transactions.last.price_cents).to eq(bill.price_cents)
      end
    end

    context 'Fail scenario'
  end
end