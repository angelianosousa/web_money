require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe 'GET /notifications' do

    it 'user logged acccess your notifications screen' do
      get notifications_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /notifications/mark_as_read/:id'
end
