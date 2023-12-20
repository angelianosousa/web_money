# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  let(:user)         { create(:user) }
  let(:notification) { create(:notification, read: false) }

  before do
    sign_in user
  end

  describe 'GET /notifications' do
    it 'user logged acccess your notifications screen' do
      get notifications_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /notifications/:id/mark_as_read' do
    describe 'read notification' do
      it 'should return success' do
        params = { id:  notification.id }
        patch mark_as_read_notification_path(notification), params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(notifications_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('notifications.mark_as_read.success'))
      end
    end
  end
end
