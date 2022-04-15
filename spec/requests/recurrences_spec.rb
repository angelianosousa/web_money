require 'rails_helper'

RSpec.describe "Recurrences", type: :request do
  let(:user) { create(:user) }
  
  describe "GET /users_backoffice/recurrences" do
    it "returns status code 200 ok" do
      sign_in user
      get users_backoffice_recurrences_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users_backoffice/recurrences" do
    context 'when has valid parameters' do
      it 'then create a new recurrence'
      it 'returns status code 201 created'
    end

    context 'when has invalid parameters' do
      it 'then does not create a recurrence'
    end
  end

  describe "PUT/PATCH /users_backoffice/recurrences/:id" do
    context 'when recurrence exists' do
      it "returns status 200 ok"
      it "update success"
    end

    context 'when recurrence does not exist' do
      it 'returns status not found'
      it 'returns status code 404 not found'
    end
  end

  describe 'DELETE /users_backoffice/recurrences/:id' do
    context 'when recurrence exists' do
      it 'returns status 204 not content'
    end

    context 'when recurrence does not exist' do
      it "returns status 404 not found"
    end
  end
end
