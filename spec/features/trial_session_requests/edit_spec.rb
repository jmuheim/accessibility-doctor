require 'rails_helper'

describe 'Editing trial session request' do
  before do
    @user = create :user, :admin
    login_as @user

    @trial_session_request = create :trial_session_request
  end

  it 'edits a trial session request' do
    visit edit_trial_session_request_path(@trial_session_request)

    expect(page).to have_title 'Edit 1 - A11y-Doc'
    expect(page).to have_active_navigation_items 'Cool parent page', 'Cool navigation title'
    expect(page).to have_breadcrumbs 'A11y-Doc', 'Cool parent page', 'Cool navigation title', 'Edit'
    expect(page).to have_headline 'Edit Page test title'

    expect(page).to have_css 'h2', text: 'Information about organising pages as tree hierarchy'
    expect(page).to have_css 'h2', text: 'Information about pasting images and CodePen links as resources'

    expect(page).to have_css 'h2', text: 'Details'

    # Changing the parent disables the position select
    expect {
      select_from_autocomplete('Cooler parent page (#2)', 'page_parent_id')
    }.to change {
      page.has_css? '#page_position[disabled]'
    }.from(false).to true

    # Changing the parent back to the original value re-enables the position select
    expect {
      select_from_autocomplete('Cool parent page (#1)', 'page_parent_id')
    }.to change {
      page.has_css? '#page_position[disabled]'
    }.from(true).to false

    fill_in 'page_parent_id_filter', with: 'Cooler'
    find('label[for="page_parent_id_2"]').click
    fill_in 'page_title',            with: 'A new title'
    fill_in 'page_navigation_title', with: 'A new navigation title'
    fill_in 'page_content',          with: "A new content with a ![existing image](@image-existing-image) and a ![new image](@image-new-image). Also an ![existing code](@code-existing-code) and a ![new code](@code-new-code). "
    fill_in 'page_notes',            with: 'A new note'

    find('#page_images_attributes_0_file', visible: false).set base64_other_image[:data]
    fill_in 'page_images_attributes_0_identifier', with: 'existing-image'

    fill_in 'page_codes_attributes_0_identifier', with: 'existing-code'

    # Let's add an image that is referenced in the content
    expect {
      click_link 'Create Image'
    } .to change { all('#images .nested-fields').count }.by 1

    scroll_by(0, 10000) # Otherwise the footer overlaps the element and results in a Capybara::Poltergeist::MouseEventFailed, see http://stackoverflow.com/questions/4424790/cucumber-capybara-scroll-to-bottom-of-page
    nested_field_id = get_latest_nested_field_id(:page_images)
    fill_in "page_images_attributes_#{nested_field_id}_identifier", with: 'new-image'
    fill_in "page_images_attributes_#{nested_field_id}_file", with: base64_image[:data]

    # Let's add another image that's not referenced
    click_link 'Create Image'
    nested_field_id = get_latest_nested_field_id(:page_images)
    fill_in "page_images_attributes_#{nested_field_id}_file", with: base64_image[:data]
    fill_in "page_images_attributes_#{nested_field_id}_identifier", with: 'abandoned-image'

    # Let's add a code that is referenced in the content
    expect {
      click_link 'Create Code'
    } .to change { all('#codes .nested-fields').count }.by 1

    scroll_by(0, 10000) # Otherwise the footer overlaps the element and results in a Capybara::Poltergeist::MouseEventFailed, see http://stackoverflow.com/questions/4424790/cucumber-capybara-scroll-to-bottom-of-page
    nested_field_id = get_latest_nested_field_id(:page_codes)
    fill_in "page_codes_attributes_#{nested_field_id}_identifier", with: 'new-code'

    # Let's add another code that's not referenced
    click_link 'Create Code'
    nested_field_id = get_latest_nested_field_id(:page_codes)
    fill_in "page_codes_attributes_#{nested_field_id}_identifier", with: 'abandoned-code'

    within '.pastables' do
      expect(page).to have_css 'h2', text: 'Images'
      expect(page).to have_css 'h2', text: 'Codes'
    end

    within '.actions' do
      expect(page).to have_css 'h2', text: 'Actions'

      expect(page).to have_button 'Update Page'
      expect(page).to have_link 'List of Pages'
    end

    expect {
      click_button 'Update Page'
      @page.reload
    } .to  change { @page.title }.to('A new title')
      .and change { @page.navigation_title }.to('A new navigation title')
      .and change { @page.parent }.from(old_page_parent).to(new_parent_page)
      .and change { @page.position }.from(1).to(2)
      .and change { @page.content }.to("A new content with a ![existing image](@image-existing-image) and a ![new image](@image-new-image). Also an ![existing code](@code-existing-code) and a ![new code](@code-new-code).")
      .and change { @page.notes }.to('A new note')
      .and change { @page.images.count }.by(1)
      .and change { @page.images.first.file.file.identifier }.to('file.png')
      .and change { @page.images.first.identifier }.to('existing-image')
      .and change { @page.images.last.file.file.identifier }.to('file.png')
      .and change { @page.images.last.identifier }.to('new-image')
      .and change { @page.codes.count }.by(1)
      .and change { @page.codes.first.identifier }.to('existing-code')
      .and change { @page.codes.first.html }.to('Some HTML')
      .and change { @page.codes.first.css }.to('Some CSS')
      .and change { @page.codes.first.js }.to('Some JavaScript')
      .and change { @page.codes.last.identifier }.to('new-code')

    # Only the referenced image is kept
    expect(Image.count).to eq 2
    expect(Image.last.identifier).to eq 'new-image'

    # Only the referenced code is kept
    expect(Code.count).to eq 2
    expect(Code.last.identifier).to eq 'new-code'
  end
end
