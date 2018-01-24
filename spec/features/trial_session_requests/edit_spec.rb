require 'rails_helper'

describe 'Editing trial session request' do
  before do
    @user = create :user, :admin
    login_as @user

    @trial_session_request = create :trial_session_request
  end

  it 'edits a trial session request' do
    visit edit_trial_session_request_path(@trial_session_request)

    expect(page).to have_title 'Edit Trial Session Request test name - A11y-Doc'
    expect(page).to have_active_navigation_items 'Trial Session Requests', 'List of Trial Session Requests'
    expect(page).to have_breadcrumbs 'A11y-Doc', 'Trial Session Requests', 'Trial Session Request test...', 'Edit'
    expect(page).to have_headline 'Edit Trial Session Request test name'

    fill_in 'trial_session_request_name',    with: 'Hans Muster'
    fill_in 'trial_session_request_company', with: 'Muster Webdesign GmbH'
    fill_in 'trial_session_request_email',   with: 'hans@muster-webdesign.com'

    select 'German', from: 'trial_session_request_language'

    fill_in 'trial_session_request_url',          with: 'www.muster-webdesign.com'
    fill_in 'trial_session_request_availability', with: 'Neue Verfügbarkeit'

    select '(GMT+02:00) Athens', from: 'trial_session_request_time_zone'

    expect(page).to have_css 'select#trial_session_request_duration[disabled]'

    select 'Recommendation', from: 'trial_session_request_how_found_us'

    fill_in 'trial_session_request_message', with: 'Neue Nachricht'

    expect(page).not_to have_css 'input#trial_session_request_agree_to_terms_and_conditions'

    within '.actions' do
      expect(page).to have_css 'h2', text: 'Actions'

      expect(page).to have_button 'Update Trial Session Request'
      expect(page).to have_link 'List of Trial Session Requests'
    end

    expect {
      click_button 'Update Trial Session Request'
      @trial_session_request.reload
    } .to  change { @trial_session_request.name }.to('Hans Muster')
      .and change { @trial_session_request.company }.to('Muster Webdesign GmbH')
      .and change { @trial_session_request.email }.to('hans@muster-webdesign.com')
      .and change { @trial_session_request.language }.to('de')
      .and change { @trial_session_request.url }.to('http://www.muster-webdesign.com')
      .and change { @trial_session_request.availability }.to('Neue Verfügbarkeit')
      .and change { @trial_session_request.time_zone }.to('Athens')
      .and change { @trial_session_request.how_found_us }.to('recommendation')
      .and change { @trial_session_request.message }.to('Neue Nachricht')
  end

  it "prevents from overwriting other users' changes accidently (caused by race conditions)" do
    visit edit_trial_session_request_path(@trial_session_request)

    # Change something in the database...
    expect {
      @trial_session_request.update_attributes message: 'This is the old message'
    }.to change { @trial_session_request.lock_version }.by 1

    fill_in 'trial_session_request_message', with: 'This is the new message, yeah!'

    expect {
      click_button 'Update Trial Session Request'
      @trial_session_request.reload
    }.not_to change { @trial_session_request }

    expect(page).to have_flash('Alert: Trial Session Request meanwhile has been changed. The conflicting field is: Personal message.').of_type :alert

    expect {
      click_button 'Update Trial Session Request'
      @trial_session_request.reload
    } .to change { @trial_session_request.message }.to('This is the new message, yeah!')
  end
end
