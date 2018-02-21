require 'rails_helper'

describe 'Creating trial session request' do
  it 'blocks users signed up to fast' do
    visit new_trial_session_request_path

    expect(page).to have_css 'legend h2', text: 'Personal details'
    fill_in 'trial_session_request_name',    with: 'Hans Muster'
    fill_in 'trial_session_request_company', with: 'Muster Webdesign GmbH'
    fill_in 'trial_session_request_email',   with: 'hans@muster-webdesign.com'

    expect(page).to have_css 'legend h2', text: 'Details about the desired session'
    fill_in 'trial_session_request_availability', with: "Kommender Donnerstag, 20. Februar, zwischen 14 und 16 Uhr.\n\nOder am kommenden Freitag, 21. Februar, ganzer Tag."
    select '(GMT+02:00) Athens', from: 'trial_session_request_time_zone'

    expect(page).to have_css 'legend h2', text: 'Additional details'
    check 'trial_session_request_agree_to_terms_and_conditions'

    click_button 'Create Trial Session Request'

    expect(page).to have_flash('You filled out the form to fast').of_type :alert
  end

  it 'creates a trial session request and sends an email' do
    allow_any_instance_of(TrialSessionRequestsController).to receive(:time_required_for_input).and_return(666.seconds)
    visit new_trial_session_request_path

    expect(page).to have_title 'Create Trial Session Request - A11y-Doc'
    expect(page).to have_active_navigation_items 'Request a free trial consultation!'
    expect(page).to have_breadcrumbs 'A11y-Doc', 'Trial Session Requests', 'Create'
    expect(page).to have_headline 'Create Trial Session Request'

    expect(page).to have_css 'legend h2', text: 'Personal details'
    fill_in 'trial_session_request_name',    with: 'Hans Muster'
    fill_in 'trial_session_request_company', with: 'Muster Webdesign GmbH'
    fill_in 'trial_session_request_email',   with: 'hans@muster-webdesign.com'
    select 'German', from: 'trial_session_request_language'

    expect(page).to have_css 'legend h2', text: 'Details about the desired session'
    fill_in 'trial_session_request_url',          with: 'www.muster-webdesign.com'
    fill_in 'trial_session_request_availability', with: "Kommender Donnerstag, 20. Februar, zwischen 14 und 16 Uhr.\n\nOder am kommenden Freitag, 21. Februar, ganzer Tag."
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

    mails_for_vistor = unread_emails_for('hans@muster-webdesign.com')
    expect(mails_for_vistor.size).to eq 1
    expect(mails_for_vistor.last).to be_delivered_from("Accessibility Doctor (A11y-Doc) <#{Rails.application.secrets.mailer_from}>")
    expect(mails_for_vistor.last).to be_delivered_to("Hans Muster <hans@muster-webdesign.com>")
    expect(mails_for_vistor.last).to have_subject('Ihre Anfrage bezüglich einer Probe-Session mit Accessibility Doctor')
    expect(mails_for_vistor.last.html_part.body.raw_source).to eq "<!DOCTYPE html>\n<html lang=\"de\">\n<head>\n<title>Ihre Anfrage bezüglich einer Probe-Session mit Accessibility Doctor</title>\n<meta content=\"text/html; charset=UTF-8\" http-equiv=\"Content-Type\">\n</head>\n<body>\n<h1>Herzlichen Dank, Hans Muster!</h1>\n<p>Ich freue mich sehr über Ihre Anfrage für eine <strong>kostenlose Probe-Session</strong> mit mir.</p>\n<p>Sie werden dabei die Möglichkeit haben, mir live zuzuschauen beim Testen Ihrer Website <a href=\"http://www.muster-webdesign.com\" class=\"uri\">http://www.muster-webdesign.com</a> auf Accessibility (Barrierefreiheit). Auch Fragen und Kommentare sind dabei natürlich jederzeit willkommen!</p>\n<p>Für diese <strong>15 minütige Session</strong> haben Sie folgende zeitliche Verfügbarkeit angegeben:</p>\n<blockquote>\n<pre>Kommender Donnerstag, 20. Februar, zwischen 14 und 16 Uhr.\r\n\r\nOder am kommenden Freitag, 21. Februar, ganzer Tag.</pre>\n</blockquote>\n<p>Ich werde Sie bald persönlich kontaktieren, um einen passenden Termin zu bestätigen, oder um Ihnen Alternativen vorschlagen.</p>\n<p>Ich freue mich, Sie kennenzulernen und Sie bei Ihren Anliegen zu unterstützen.</p>\n<p>Herzliche Grüsse.</p>\n<p><strong>Joshua Muheim</strong><br>Accessibility Consultant &amp; Senior Fullstack Web Developer</p>\n<hr>\n<p><cite><strong>Accessibility Doctor</strong> - Verständliche und pragmatische Beratung zu Accessibility (Barrierefreiheit).</cite></p>\n<address>\n<strong>Email:</strong> <a href=\"mailto:#{Rails.application.secrets.mailer_from}\">#{Rails.application.secrets.mailer_from}</a><br><strong>Web:</strong> <a href=\"http://localhost:3010/\">http://localhost:3010/</a>\n</address>\n</body>\n</html>\n"
    expect(mails_for_vistor.last.text_part.body.raw_source).to eq "*****************************\nHerzlichen Dank, Hans Muster!\n*****************************\n\nIch freue mich sehr über Ihre Anfrage für eine kostenlose\nProbe-Session mit mir.\n\nSie werden dabei die Möglichkeit haben, mir live zuzuschauen beim\nTesten Ihrer Website http://www.muster-webdesign.com auf\nAccessibility (Barrierefreiheit). Auch Fragen und Kommentare sind\ndabei natürlich jederzeit willkommen!\n\nFür diese 15 minütige Session haben Sie folgende zeitliche\nVerfügbarkeit angegeben:\n\nKommender Donnerstag, 20. Februar, zwischen 14 und 16 Uhr.\n\nOder am kommenden Freitag, 21. Februar, ganzer Tag.\n\nIch werde Sie bald persönlich kontaktieren, um einen passenden\nTermin zu bestätigen, oder um Ihnen Alternativen vorschlagen.\n\nIch freue mich, Sie kennenzulernen und Sie bei Ihren Anliegen zu\nunterstützen.\n\nHerzliche Grüsse.\n\nJoshua Muheim\nAccessibility Consultant & Senior Fullstack Web Developer\n\nAccessibility Doctor - Verständliche und pragmatische Beratung zu\nAccessibility (Barrierefreiheit).\n\nEmail: #{Rails.application.secrets.mailer_from}\nWeb: http://localhost:3010/"

    mails_for_doctor = unread_emails_for(Rails.application.secrets.mailer_from)
    expect(mails_for_doctor.size).to eq 1
    expect(mails_for_doctor.last).to be_delivered_from("Accessibility Doctor (A11y-Doc) <#{Rails.application.secrets.mailer_from}>")
    expect(mails_for_doctor.last).to be_delivered_to("Accessibility Doctor (A11y-Doc) <#{Rails.application.secrets.mailer_from}>")
    expect(mails_for_doctor.last).to have_subject('New request for a trial session by Hans Muster (Muster Webdesign GmbH)')
    expect(mails_for_doctor.last.html_part.body.raw_source).to eq "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<title>New request for a trial session by Hans Muster (Muster Webdesign GmbH)</title>\n<meta content=\"text/html; charset=UTF-8\" http-equiv=\"Content-Type\">\n</head>\n<body>\n<h1>New request for a trial session</h1>\n<p>Hans Muster from Muster Webdesign GmbH has requested a trial session.</p>\n<p>The client specified the following availability:</p>\n<blockquote>\n<pre>Kommender Donnerstag, 20. Februar, zwischen 14 und 16 Uhr.\n\nOder am kommenden Freitag, 21. Februar, ganzer Tag.</pre>\n</blockquote>\n<p>Please <a href=\"http://localhost:3010/de/trial_session_requests/1\">act upon the request</a> soon!</p>\n<p><strong>Joshua Muheim</strong><br>Accessibility consultant &amp; senior full stack web developer</p>\n<hr>\n<p><cite><strong>Accessibility Doctor</strong> - Comprehensible and pragmatic accessibility consulting.</cite></p>\n<address>\n<strong>Email:</strong> <a href=\"mailto:#{Rails.application.secrets.mailer_from}\">#{Rails.application.secrets.mailer_from}</a><br><strong>Web:</strong> <a href=\"http://localhost:3010/\">http://localhost:3010/</a>\n</address>\n</body>\n</html>\n"
    expect(mails_for_doctor.last.text_part.body.raw_source).to eq "*******************************\nNew request for a trial session\n*******************************\n\nHans Muster from Muster Webdesign GmbH has requested a trial\nsession.\n\nThe client specified the following availability:\n\nKommender Donnerstag, 20. Februar, zwischen 14 und 16 Uhr.\n\nOder am kommenden Freitag, 21. Februar, ganzer Tag.\n\nPlease act upon the request \n( http://localhost:3010/de/trial_session_requests/1 ) soon!\n\nJoshua Muheim\nAccessibility consultant & senior full stack web developer\n\nAccessibility Doctor - Comprehensible and pragmatic accessibility\nconsulting.\n\nEmail: #{Rails.application.secrets.mailer_from}\nWeb: http://localhost:3010/"
  end
end
