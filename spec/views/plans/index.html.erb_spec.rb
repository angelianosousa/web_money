require 'rails_helper'

RSpec.describe "plans/index", type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :name => "Name",
        :user_profile => nil
      ),
      Plan.create!(
        :name => "Name",
        :user_profile => nil
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
