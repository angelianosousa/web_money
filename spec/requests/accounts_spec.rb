require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:user)    { create(:user) }
  let(:account) { create(:account, user_profile: user.user_profile) }

  before do
    sign_in user
  end
  
  describe 'GET /accounts' do

    it 'user logged acccess your accoumt' do
      get accounts_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /accounts' do
    let(:account_attributes) { attributes_for(:account, user_profile: user.user_profile) }
    let(:account_attributes_invalid) { attributes_for(:account, user_profile: user.user_profile, title: '') }

    context 'User fill the account form' do
      it 'should save account with valid attributes' do
        params = { account: account_attributes }
        post accounts_path, params: params
  
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(accounts_path)
        follow_redirect!
  
        expect(response.body).to include(I18n.t('accounts.create.success'))
      end
  
      it 'should not save account with invalid attributes' do
        params = { account: account_attributes_invalid }
        post accounts_path, params: params
  
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(accounts_path)      
      end
    end
  end

  describe 'PATCH /accounts/:id' do
    context 'fill form with valid attributes' do
      it 'should get edit form account'
      it 'should save account'
    end
  end

  describe 'DESTROY /accounts/:id' do
    it 'should delete account'
  end

  describe 'POST /accounts/transfer_between_accounts' do
    context 'User fil form with valid information' do
      it 'Movement should be saved'
    end

    context 'User fill the form with same account to account_id_in and account_id_out' do
      it 'Movement should not be saved'
      it 'Movement should get errors'
      it 'User must have to see the errors on screen'
    end
  end

end
