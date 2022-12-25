require 'rails_helper'

RSpec.describe "bills/index", type: :view do
  before(:each) do
    assign(:bills, [
      Bill.create!(
        :title => "Title",
        :value => "9.99",
        :bill_type => 2,
        :status => 3
      ),
      Bill.create!(
        :title => "Title",
        :value => "9.99",
        :bill_type => 2,
        :status => 3
      )
    ])
  end

  it "renders a list of bills" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
