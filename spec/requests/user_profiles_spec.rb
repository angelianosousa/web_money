require 'rails_helper'

RSpec.describe "UserProfiles", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe 'GET /user_profile/:id/edit' do

    it 'user logged acccess your profile screen' do
      get edit_user_profile_path(user.user_profile)

      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /user_profile/:id'
end
