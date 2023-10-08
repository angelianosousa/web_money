# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'budgets/show', type: :view do
  let(:user_profile) { create(:user_profile) }
  before(:each) do
    sign_in(user_profile.user)
    @budget = assign(:budget, Budget.create!(
                                objective_name: 'Objective Name',
                                goals_price: 9.99,
                                user_profile: user_profile
                              ))
  end

  it 'renders attributes in <p>' do
    # TODO: there is not any layout of that
    # render
    # expect(rendered).to match(/Objective Name/)
    # expect(rendered).to match(/9.99/)
    # expect(rendered).to match(//)
  end
end
