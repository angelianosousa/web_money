require 'rails_helper'

RSpec.describe "accounts/edit", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :title => "MyString",
      :value => "9.99",
      :user_profile => nil
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input[name=?]", "account[title]"

      assert_select "input[name=?]", "account[value]"

      assert_select "input[name=?]", "account[user_profile_id]"
    end
  end
end
