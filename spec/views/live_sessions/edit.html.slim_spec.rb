require 'rails_helper'

RSpec.describe "live_sessions/edit", type: :view do
  before(:each) do
    @live_session = assign(:live_session, LiveSession.create!(
      :customer_name => "MyString",
      :customer_email => "MyString",
      :url => "MyString",
      :description => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit live_session form" do
    render

    assert_select "form[action=?][method=?]", live_session_path(@live_session), "post" do

      assert_select "input[name=?]", "live_session[customer_name]"

      assert_select "input[name=?]", "live_session[customer_email]"

      assert_select "input[name=?]", "live_session[url]"

      assert_select "textarea[name=?]", "live_session[description]"

      assert_select "textarea[name=?]", "live_session[notes]"
    end
  end
end
