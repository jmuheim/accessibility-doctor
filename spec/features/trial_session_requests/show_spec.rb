require 'rails_helper'

describe 'Showing trial session request' do
  context 'as a guest' do
    before { @trial_session_request = create :trial_session_request }

    it 'displays a "thank you" message' do
      visit trial_session_request_path(@trial_session_request)

      expect(page).to have_title 'Trial Session Request test name - A11y-Doc'
      expect(page).to have_active_navigation_items 'Trial Session Requests'
      expect(page).to have_breadcrumbs 'A11y-Doc', 'Trial Session Requests', 'Trial Session Request test...'
      expect(page).to have_headline 'Trial Session Request test name'

      expect(page).to have_test 'Your request has been received successfully and I will take care of its processing!'
    end
  end

  context 'as an adming' do
    before do
      @user = create :user, :admin
      login_as(@user)

      @trial_session_request = create :trial_session_request
    end

    it 'displays a trial session request' do
      visit trial_session_request_path(@trial_session_request)

      expect(page).to have_title 'Trial Session Request test name - A11y-Doc'
      expect(page).to have_active_navigation_items 'Trial Session Requests'
      expect(page).to have_breadcrumbs 'A11y-Doc', 'Trial Session Requests', 'Trial Session Request test...'
      expect(page).to have_headline 'Trial Session Request test name'

      within dom_id_selector(@trial_session_request) do
        expect(page).to have_css '.time_zone', text: 'Riga'

        within '.availability' do
          expect(page).to have_css 'h2', text: 'Availability'
          expect(page).to have_css 'pre', text: 'Trial Session Request test availability'
        end

        within '.message' do
          expect(page).to have_css 'h2', text: 'Personal message'
          expect(page).to have_css 'pre', text: 'Trial Session Request test message'
        end

        within '.additional_information' do
          expect(page).to have_css '.url a',      text: 'http://www.example.com'
          expect(page).to have_css '.language',   text: 'English'
          expect(page).to have_css '.name',       text: 'Trial Session Request test name'
          expect(page).to have_css '.company',    text: 'Trial Session Request test company'
          expect(page).to have_css '.email a',    text: 'test@example.com'
          expect(page).to have_css '.created_at', text: 'Mon, 15 Jun 2015 14:33:52 +0200'
          expect(page).to have_css '.updated_at', text: 'Mon, 15 Jun 2015 14:33:52 +0200'
        end

        within '.actions' do
          expect(page).to have_css 'h2', text: 'Actions'

          expect(page).to have_link 'Edit'
          expect(page).to have_link 'Delete'
          expect(page).to have_link 'Create Trial Session Request'
          expect(page).to have_link 'List of Trial Session Requests'
        end
      end
    end
  end
end
