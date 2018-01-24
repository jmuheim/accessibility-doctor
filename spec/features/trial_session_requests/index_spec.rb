require 'rails_helper'

describe 'Listing trial session requests' do
  before do
    @user = create :user, :admin
    login_as(@user)

    @trial_session_request = create :trial_session_request
  end

  it 'displays trial session requests' do
    visit trial_session_requests_path

    expect(page).to have_title 'Trial Session Requests - A11y-Doc'
    expect(page).to have_active_navigation_items 'Trial Session Requests', 'List of Trial Session Requests'
    expect(page).to have_breadcrumbs 'A11y-Doc', 'Trial Session Requests'
    expect(page).to have_headline 'Trial Session Requests'

    within dom_id_selector(@trial_session_request) do
      expect(page).to have_css '.name a',   text: 'Trial Session Request test name'
      expect(page).to have_css '.url',      text: 'http://www.example.com'
      expect(page).to have_css '.company',  text: 'Trial Session Request test company'
      expect(page).to have_css '.email a',  text: 'test@example.com'
      expect(page).to have_css '.language', text: 'English'

      expect(page).to have_link 'Edit'
      expect(page).to have_link 'Delete'
    end

    within 'div.actions' do
      expect(page).to have_css 'h2', text: 'Actions'
      expect(page).to have_link 'Create Trial Session Request'
    end
  end
end
