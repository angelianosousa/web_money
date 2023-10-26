# frozen_string_literal: true

require 'rails_helper'
require './app/services/create_payment'

RSpec.describe CreatePayment do
  describe '#call' do
    let(:user)    { create(:user) }
    let(:account) { create(:account, user_id: user.id) }
    let(:bill)    { create(:bill, user_id: user.id) }
    let(:transaction_params) do
      attributes_for(:transaction, price_cents: bill.price_cents, account_id: account.id)
    end

    context 'Success scenario' do
      let(:payment) { CreatePayment.call(user, bill, transaction_params) }

      it 'validate @payment' do
        expect(payment.valid?).to be_truthy
      end

      it '@payment paid' do
        expect(payment.status).to eq('paid')
      end

      it '@payment with valid integral transaction' do
        expect(payment.transactions.last.price_cents.to_f).to eq(bill.price_cents.to_f)
      end
    end

    context 'Fail scenario'
  end
end