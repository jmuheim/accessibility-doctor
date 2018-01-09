require 'rails_helper'

RSpec.describe "live_sessions/show", type: :view do
  before(:each) do
    @live_session = assign(:live_session, LiveSession.create!(
      :customer_name => "Customer Name",
      :customer_email => "Customer Email",
      :url => "Url",
      :description => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Customer Name/)
    expect(rendered).to match(/Customer Email/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
