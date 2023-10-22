# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bills', type: :request do
  let(:user) { create(:user) }
  let(:bill) { create(:bill, user_profile: user.user_profile) }

  before do
    sign_in user
  end

  describe 'GET /bills' do
    it 'user logged access your bills screen' do
      get bills_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /bills/:id' do
    it 'User see informations abount the bill and the all movements realized' do
      get bill_path(bill)

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /bills' do
    context 'Success Scenario' do
      let(:bill_attributes) { attributes_for(:bill, user_profile: user.user_profile) }

      it 'should save account with valid attributes' do
        params = { bill: bill_attributes }
        post bills_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(bills_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('bills.create.success'))
      end
    end

    context 'Fail Scenarios' do
      let(:bill_attributes_invalid) do
        attributes_for(:bill, user_profile: user.user_profile, title: nil, date: nil, price_cents: -1)
      end

      it 'should not save with title, date or price_cents invalid' do
        params = { bill: bill_attributes_invalid }
        post bills_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(bills_path)
      end
    end
  end

  describe 'GET /bills/:id' do
    it 'should return success' do
      get edit_bill_path(bill)

      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT | PATCH /bills/:id' do
    context 'Success Scenario' do
      let(:new_bill_attributes) { attributes_for(:bill, user_profile: user.user_profile, title: 'My title') }

      it 'update bill, should return success' do
        params = { bill: new_bill_attributes }
        put bill_path(bill), params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(bills_path)
        follow_redirect!

        expect(response.body).to include(I18n.t('bills.update.success'))
      end
    end

    context 'Fail Scenario' do
      let(:bill_attributes_invalid) do
        attributes_for(:bill, user_profile: user.user_profile, title: nil, date: nil, price_cents: -1)
      end

      describe 'when given title, date or price_cents empty' do
        it 'should not save' do
          params = { bill: bill_attributes_invalid }
          put bill_path(bill), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_bill_path(bill))
        end
      end
    end
  end

  describe 'DELETE /bills/:id' do
    it 'should delete bill' do
      expect do
        delete bill_path(bill)
      end.to change(Bill, :count).by(0)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include(I18n.t('bills.destroy.success'))
    end
  end

  # describe 'POST /bills/:bill_id/new_transaction'
end
