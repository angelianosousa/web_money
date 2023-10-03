# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'budgets/index', type: :view do
  let(:user_profile) { create(:user_profile) }

  before(:each) do
    sign_in(user_profile.user)

    assign(:budgets, [
             Budget.create!(
               objective_name: Faker::Name.unique.name,
               goals_price: 9.99,
               user_profile: user_profile
             ),
             Budget.create!(
               objective_name: Faker::Name.unique.name,
               goals_price: 9.99,
               user_profile: user_profile
             )
           ])
  end

  it 'renders a list of budgets' do
    render
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
