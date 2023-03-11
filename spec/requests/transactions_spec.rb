require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user) { create(:user) }

  describe "GET /transactions" do
    it "returns status code 200 ok" do
      sign_in user
      get transactions_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /transactions/:id" do
    context 'when has valid parameters' do
      it 'then create a new recurrence'
      it 'returns status code 201 created'
    end

    context 'when has invalid parameters' do
      it 'then does not create a recurrence'
    end
  end

  describe "PUT/PATCH /transactions/:id" do
    context 'when transaction exists' do
      it "returns status 200 ok"
      it "update success"
    end

    context 'when transaction does not exist' do
      it 'returns status not found'
      it 'returns status code 404 not found'
    end
  end

  describe 'DELETE /transactions/:id' do
    context 'when transaction exists' do
      it 'returns status 204 not content'
    end

    context 'when transaction does not exist' do
      it "returns status 404 not found"
    end
  end
end
