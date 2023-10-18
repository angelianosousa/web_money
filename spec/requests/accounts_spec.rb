# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user_profile: user.user_profile) }
  let(:transactions) { create_list(:transaction, 3, user_profile: user.user_profile) }

  before do
    sign_in user
  end

  describe 'GET /accounts' do
    it 'user logged acccess your accoumt' do
      get accounts_path

      expect(response).to have_http_status(200)
      # expect(response).to render_template()
    end
  end

  describe 'POST /accounts' do
    let(:account_attributes) { attributes_for(:account, user_profile: user.user_profile) }
    let(:account_attributes_invalid) { attributes_for(:account, user_profile: user.user_profile, title: '') }

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
      follow_redirect!

      expect(request.flash[:danger]).to eq(account_attributes_invalid.errors.full_messages.to_sentence)
    end
  end

  # describe 'PATCH /accounts' do
  #   it
  # end
end
