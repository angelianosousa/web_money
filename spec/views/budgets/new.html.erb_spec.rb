# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'budgets/new', type: :view do
  before(:each) do
    assign(:budget, Budget.new(
                      objective_name: 'MyString',
                      goals_price: '9.99',
                      user_profile: nil
                    ))
  end

  it 'renders new budget form' do
    render

    assert_select 'form[action=?][method=?]', budgets_path, 'post' do
      assert_select 'input[name=?]', 'budget[objective_name]'

      assert_select 'input[name=?]', 'budget[goals_price]'

      assert_select 'input[name=?]', 'budget[user_profile_id]'
    end
  end
end
