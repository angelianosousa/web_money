require 'rails_helper'

RSpec.describe "bills/edit", type: :view do
  before(:each) do
    @bill = assign(:bill, Bill.create!(
      :title => "MyString",
      :value => "9.99",
      :bill_type => 1,
      :status => 1
    ))
  end

  it "renders the edit bill form" do
    render

    assert_select "form[action=?][method=?]", bill_path(@bill), "post" do

      assert_select "input[name=?]", "bill[title]"

      assert_select "input[name=?]", "bill[value]"

      assert_select "input[name=?]", "bill[bill_type]"

      assert_select "input[name=?]", "bill[status]"
    end
  end
end
