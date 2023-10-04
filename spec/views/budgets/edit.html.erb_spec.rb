# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'budgets/edit', type: :view do
  before(:each) do
    @budget = assign(:budget, Budget.create!(
                                objective_name: 'MyString',
                                goals_price: '9.99',
                                user_profile: nil
                              ))
  end

  it 'renders the edit budget form' do
    render

    assert_select 'form[action=?][method=?]', budget_path(@budget), 'post' do
      assert_select 'input[name=?]', 'budget[objective_name]'

      assert_select 'input[name=?]', 'budget[goals_price]'

      assert_select 'input[name=?]', 'budget[user_profile_id]'
    end
  end
end
