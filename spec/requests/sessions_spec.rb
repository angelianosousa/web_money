# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'new_session_form' do
    it 'render session form' do
      get new_user_session_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'sign_in' do
    let(:user) { create(:user) }

    context 'Fail Scenario' do
      describe 'user use invalid attributes' do
        it 'should not authenticate' do
          params = { email: nil, password: nil }
          post user_session_path, params: params

          expect(response).to have_http_status(200)
        end
      end
    end

    context 'Success Scenario' do
      it 'user logged in' do
        params = { email: user.email, password: user.password }
        post user_session_path, params: params

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'sign_out' do
    let(:user) { create(:user) }

    it 'user logged out' do
      sign_in user

      delete destroy_user_session_path

      expect(response).to have_http_status(302)
    end
  end
end