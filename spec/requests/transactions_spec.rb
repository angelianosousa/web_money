# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  let(:user_profile) { create(:user_profile) }

  let(:transaction) do
    create(:transaction, user_profile: user_profile) do |t|
      t.create_category(attributes_for(:category, user_profile_id: user_profile.id))
      t.create_account(attributes_for(:account, user_profile_id: user_profile.id))
    end
  end

  before do
    sign_in user_profile.user
  end

  describe 'GET /transactions' do
    describe 'User access the transaction screen' do
      it 'And see all your transactions' do
        get transactions_path

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /transactions' do
    let(:account)  { create(:account, user_profile_id: user_profile.id) }
    let(:category) { create(:category, user_profile_id: user_profile.id) }

    context 'Success Scenario' do
      let(:transaction_attributes) do
        attributes_for(:transaction, user_profile_id: user_profile.id, account_id: account.id, category_id: category.id)
      end

      describe 'fill the form with valid information' do
        it 'should save transaction with valid attributes' do
          params = { transaction: transaction_attributes }
          post transactions_path, params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(transactions_path)
          follow_redirect!
          expect(response.body).to include(I18n.t('transactions.create.success'))
        end
      end
    end
  end

  describe 'GET /transactions/:id/edit' do
    it 'Getting transaction update form' do
      get edit_transaction_path(transaction)

      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /transactions/:id' do
    context 'Success Scenario' do
      let(:transaction_attributes) { attributes_for(:transaction, user_profile_id: user_profile.id) }

      describe 'update transaction' do
        it 'should return success' do
          params = { transaction: transaction_attributes }
          patch transaction_path(transaction), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(transactions_path)
          follow_redirect!
          expect(response.body).to include(I18n.t('transactions.update.success'))
        end
      end
    end

    # context 'Fail Scenario' do
    #   let(:transaction_attributes_invalid) { attributes_for(:transaction, :invalid)}

    #   it 'should not update transactin with invalid attributes' do
    #     params = { transaction: transaction_attributes_invalid }
    #     patch transaction_path(transaction), params: params

    #     expect(response).to have_http_status(302)
    #     expect(response).to redirect_to(edit_transaction_path(transaction))
    #     expect(transaction).to raise ActiveRecord::RecordInvalid
    #   end
    # end
  end

  describe 'DELETE /transactions/:id' do
    it 'should delete transaction' do
      expect do
        delete transaction_path(transaction)
      end.to change(Transaction, :count).by(0)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include(I18n.t('transactions.destroy.success'))
    end
  end
end
