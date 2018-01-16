require 'rails_helper'

describe 'Creating trial session request' do
  it 'creates a trial session request and sends an email' do
    visit new_trial_session_request_path

    expect(page).to have_title 'Create Trial Session Request - Base'
    # expect(page).to have_active_navigation_items 'Pages', 'Create Page'
    expect(page).to have_breadcrumbs 'Base', 'Trial Session Requests', 'Create'
    expect(page).to have_headline 'Create Trial Session Request'

    expect(page).to have_css 'legend h2', text: 'Personal details'
    fill_in 'trial_session_request_name',    with: 'Hans Muster'
    fill_in 'trial_session_request_company', with: 'Muster Webdesign GmbH'
    fill_in 'trial_session_request_email',   with: 'hans@muster-webdesign.com'
    select 'German', from: 'trial_session_request_language'

    expect(page).to have_css 'legend h2', text: 'Details about the desired session'
    fill_in 'trial_session_request_url',          with: 'www.muster-webdesign.com'
    fill_in 'trial_session_request_availability', with: "Upcoming Thursday, 20th of February, around 2pm to 4pm.\n\nOr upcoming Friday, 21th of February, around 9am to 12am."
    select '(GMT+02:00) Athens', from: 'trial_session_request_time_zone'
    expect(page).to have_css 'select#trial_session_request_duration[disabled]'

    expect(page).to have_css 'legend h2', text: 'Additional details'
    select 'Other', from: 'trial_session_request_how_found_us'
    fill_in 'trial_session_request_message', with: "Ich benötige unbedingt Ihre Hilfe!\n\nKoste es, was es wolle.\n\nDanke!"
    check 'trial_session_request_agree_to_terms_and_conditions'

    expect(page).to have_css 'legend h2', text: 'Security question (CAPTCHA)'
    fill_in 'trial_session_request_humanizer_answer', with: '5'

    within '.actions' do
      expect(page).to have_css 'h2', text: 'Actions'

      expect(page).to have_button 'Create Trial Session Request'
      expect(page).not_to have_link 'List of Trial Session Requests'
    end

    click_button 'Create Trial Session Request'

    expect(page).to have_flash 'Trial Session Request was successfully created.'
  end
end
