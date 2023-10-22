# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserProfiles', type: :request do
  let(:user)         { create(:user) }
  let(:user_profile) { create(:user_profile, user: user) }

  before do
    sign_in user_profile.user
  end

  describe 'GET /user_profile/:id/edit' do
    it 'user logged acccess your profile screen' do
      get edit_user_profile_path(user_profile)

      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /user_profile/:id' do
    context 'Success Scenario' do
      let(:user_profile_attributes) { attributes_for(:user_profile, user: user) }

      describe 'user send profile valid informations' do
        it 'save profile' do
          params = { user_profile: user_profile_attributes }
          patch user_profile_path(user_profile), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_user_profile_path(user_profile))
          follow_redirect!
          expect(response.body).to include(I18n.t('user_profile.update.success'))
        end
      end
    end
  end
end
