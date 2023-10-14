require 'rails_helper'

RSpec.describe "Budgets", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe 'GET /budgets' do

    it 'user logged acccess your budgets screen' do
      get budgets_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /budgets'
  describe 'PATCH /budgets/:id'
  describe 'DESTROY /budgets/:id'
end
