require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe 'GET /categories' do

    it 'user logged acccess your categories screen' do
      get categories_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /categories'
  describe 'PATCH /categories/:id'
  describe 'DESTROY /categories/:id'
end
