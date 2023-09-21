require 'acceptance_helper'

let!(:user_profile) do
  create(:user_profile)
end

resource 'Account' do
  get '/accounts' do
    example 'Getting user information' do
      explanation 'This endpoint returns the accounts information'

      params = {}

      do_request(params)

      expect(status).to eq(200)
    end
  end
end