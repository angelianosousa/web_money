require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :name => "Name",
      :user_profile => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
