require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe 'GET /transactions' do

    it 'user logged acccess your transactions screen' do
      get transactions_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /transactions'
  describe 'PATCH /transactions/:id'
  describe 'DESTROY /transactions/:id'
end
