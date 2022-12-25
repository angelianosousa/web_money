require 'rails_helper'

RSpec.describe "bills/new", type: :view do
  before(:each) do
    assign(:bill, Bill.new(
      :title => "MyString",
      :value => "9.99",
      :bill_type => 1,
      :status => 1
    ))
  end

  it "renders new bill form" do
    render

    assert_select "form[action=?][method=?]", bills_path, "post" do

      assert_select "input[name=?]", "bill[title]"

      assert_select "input[name=?]", "bill[value]"

      assert_select "input[name=?]", "bill[bill_type]"

      assert_select "input[name=?]", "bill[status]"
    end
  end
end
