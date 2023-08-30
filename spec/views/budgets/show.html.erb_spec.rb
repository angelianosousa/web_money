# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'budgets/show', type: :view do
  before(:each) do
    @budget = assign(:budget, Budget.create!(
                                objective_name: 'Objective Name',
                                goals_price: '9.99',
                                user_profile: nil
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Objective Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
