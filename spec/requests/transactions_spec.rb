require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user)         { create(:user) }
  let(:new_category) { create(:category, user_profile: user.user_profile) }
  let(:new_account)  { create(:account, user_profile: user.user_profile) }
  let(:transaction)  { create(:transaction, user_profile: user.user_profile, category: new_category, account: new_account) }

  before do
    sign_in user
  end

  describe 'GET /transactions' do

    it 'user logged acccess your transactions screen' do
      get transactions_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /transactions' do
    context 'Success Scenario' do
      # let(:transaction_attributes) { attributes_for(:transaction, user_profile_id: user.user_profile_id, category_id: new_category.id, account_id: new_account.id) }

      it 'should save transaction with valid attributes' do
        params = { transaction: {
          user_profile_id: user.user_profile.id,
          account_id: new_account.id,
          category_id: new_category.id,
          description: 'Description test',
          price_cents: 1,
          date: Date.today
        }}
        # byebug
        post transactions_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(transactions_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('transactions.create.success'))
      end
    end

    context 'Fail Scenario' do
      let(:transaction_attributes) { attributes_for(:transaction) }

      it 'should not save with title, date or price_cents invalid'
    end
  end

  describe 'GET /transactions/:id'

  describe 'PATCH /transactions/:id' do
    context 'Success Scenario'
    context 'Fail Scenario'
  end

  describe 'DESTROY /transactions/:id' do
    it 'should delete transaction' do
      expect {
        delete transaction_path(transaction)
      }.to change(Transaction, :count).by(0)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include(I18n.t('transactions.destroy.success'))
    end
  end
end
