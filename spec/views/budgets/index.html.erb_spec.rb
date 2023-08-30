# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'budgets/index', type: :view do
  before(:each) do
    assign(:budgets, [
             Budget.create!(
               objective_name: 'Objective Name',
               goals_price: '9.99',
               user_profile: nil
             ),
             Budget.create!(
               objective_name: 'Objective Name',
               goals_price: '9.99',
               user_profile: nil
             )
           ])
  end

  it 'renders a list of budgets' do
    render
    assert_select 'tr>td', text: 'Objective Name'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
