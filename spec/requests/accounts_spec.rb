# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:achievement_money_managed)  { create(:achievement, level: :silver, code: :money_managed) }
  let(:achievement_money_movement) { create(:achievement, level: :silver, code: :money_movement) }
  let(:achievement_budget_reached) { create(:achievement, level: :silver, code: :budget_reached) }

  let(:user) do
    create(:user) do |user|
      user.achievements << [achievement_money_managed, achievement_money_movement, achievement_budget_reached]
    end
  end

  let(:account) { create(:account, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'GET /accounts' do
    it 'user logged acccess your accoumt' do
      get accounts_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /accounts' do
    let(:account_attributes)         { attributes_for(:account, user: user) }
    let(:account_attributes_invalid) { attributes_for(:account, user: user, title: '') }

    context 'Success Scenario' do
      it 'should save account with valid attributes' do
        params = { account: account_attributes }
        post accounts_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(accounts_path)
        follow_redirect!

        expect(response.body).to include(I18n.t('accounts.create.success'))
      end
    end

    context 'Fail Scenarios' do
      it 'should not save account with invalid attributes' do
        params = { account: account_attributes_invalid }
        post accounts_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(accounts_path)
      end
    end
  end

  describe 'GET /accounts/:id' do
    it 'should return success' do
      get edit_account_path(account)

      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT | PATCH /accounts/:id' do
    context 'Success Scenario' do
      let(:new_account_attributes) { attributes_for(:account, user: user) }

      it 'update account, should return success' do
        params = { account: new_account_attributes }
        put account_path(account), params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(accounts_path)
        follow_redirect!

        expect(response.body).to include(I18n.t('accounts.update.success'))
      end
    end

    context 'Fail Scenarios' do
      describe 'When given a title name empty' do
        let(:account_with_title_empty) { attributes_for(:account, user: user, title: '') }

        it 'should return account invalid' do
          params = { account: account_with_title_empty }
          put account_path(account), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_account_url(account))
        end
      end

      describe 'When given a amount minor than 0' do
        let(:account_with_amount_negative) { attributes_for(:account, user: user, price_cents: -1) }

        it 'should return account invalid' do
          params = { account: account_with_amount_negative }
          put account_path(account), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_account_url(account))
        end
      end
    end
  end

  describe 'DESTROY /accounts/:id' do
    let(:new_account) { create(:account, user: user) }

    context 'Success Scenario' do
      it 'should delete account' do
        expect do
          delete account_path(new_account)
        end.to change(Account, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST /accounts/transfer_between_accounts' do
    let(:account_out) { create(:account, user: user, price_cents: 1000) }

    context 'Success Scenario' do
      it 'User fil form with valid information' do
        params = {
          user: user,
          price_cents: 500,
          account_id_in: account.id,
          account_id_out: account_out.id
        }

        post transfer_between_accounts_accounts_path, params: params

        expect(response).to have_http_status(302)
        follow_redirect!
        expect(response.body).to include I18n.t('accounts.transfer_between_accounts.success')
      end
    end

    context 'Fail Scenario' do
      describe 'User fill the form with same account' do
        let(:new_account) { create(:account, user: user) }

        it 'Movement should get error for same account' do
          params = {
            user: user,
            price_cents: 100,
            account_id_in: new_account.id,
            account_id_out: new_account.id
          }

          post transfer_between_accounts_accounts_path, params: params
          expect(response).to have_http_status(302)
          follow_redirect!
          expect(response.body).to include I18n.t('accounts.transfer_between_accounts.errors.same_account')
        end
      end

      describe 'when user get more money than available on account' do
        let(:account_out) { create(:account, user: user, price_cents: 100) }

        it 'Should get a error for amount insufficient' do
          params = {
            user: user,
            price_cents: 200,
            account_id_in: account.id,
            account_id_out: account_out.id
          }
  
          post transfer_between_accounts_accounts_path, params: params
          expect(response).to have_http_status(302)
          follow_redirect!
          # byebug
          message = I18n.t('accounts.transfer_between_accounts.errors.insufficient_amount', account_title: account_out.title)
          expect(response.body).to include message
        end
      end
    end
  end
end
