require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :title => "Title",
      :value => "9.99",
      :user_profile => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
