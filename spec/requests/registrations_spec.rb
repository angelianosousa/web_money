# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET sign_up' do
    it 'get sign up form' do
      get new_user_registration_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'user_registration' do
    context 'Success Scenario' do
      let(:user_attributes) { attributes_for(:user) }

      it 'should create a new user and access the dashboard' do
        params = { user: user_attributes }

        post user_registration_path, params: params
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq('Bem-vindo! Você se registrou com sucesso.')
        expect(User.count.zero?).to be_falsey
      end
    end

    context 'Fail Scenario' do
      let(:user_attributes) { attributes_for(:user, :invalid) }

      it 'should not create a new user' do
        params = { user: user_attributes }

        post user_registration_path, params: params
        expect(response).to have_http_status(200)
        expect(response.body).to include 'E-mail não pode ficar em branco'
        expect(response.body).to include 'Senha não pode ficar em branco'
      end
    end
  end

  describe 'users/edit' do
    context 'Success Scenario' do
      let(:user) { create(:user) }

      it 'get user edit form' do
        sign_in user

        get edit_user_registration_path(user)

        expect(response).to have_http_status(200)
      end

      it 'should update user' do
        sign_in user

        params = {
          user: {
            username: 'Vitor Silva',
            email: 'vitor.silva@test.com',
            current_password: 'password'
          }
        }

        patch user_registration_path, params: params

        expect(response).to have_http_status(302)
        follow_redirect!
        expect(response.body).to include 'A sua conta foi atualizada com sucesso.'
      end
    end
  end
end
