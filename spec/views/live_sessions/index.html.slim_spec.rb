require 'rails_helper'

RSpec.describe "live_sessions/index", type: :view do
  before(:each) do
    assign(:live_sessions, [
      LiveSession.create!(
        :customer_name => "Customer Name",
        :customer_email => "Customer Email",
        :url => "Url",
        :description => "MyText",
        :notes => "MyText"
      ),
      LiveSession.create!(
        :customer_name => "Customer Name",
        :customer_email => "Customer Email",
        :url => "Url",
        :description => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of live_sessions" do
    render
    assert_select "tr>td", :text => "Customer Name".to_s, :count => 2
    assert_select "tr>td", :text => "Customer Email".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
