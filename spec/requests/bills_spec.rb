require 'rails_helper'

RSpec.describe "Bills", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe 'GET /bills' do

    it 'user logged acccess your bills screen' do
      get bills_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /bills/:id'
  describe 'POST /bills'
  describe 'POST /bills/:bill_id/new_transaction'
  describe 'PATCH /bills/:id'
  describe 'DESTROY /bills/:id'
end
