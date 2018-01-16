require 'rails_helper'

describe 'Showing trial session request' do
  before do
    @user = create :user, :admin
    login_as(@user)
  end

  it 'displays a trial session request' do
    @trial_session_request = create :trial_session_request
    visit trial_session_request_path(@trial_session_request)

    expect(trial_session_request).to have_title '1 - Base'
    # expect(trial_session_request).to have_active_navigation_items 'Page test navigation title'
    expect(trial_session_request).to have_breadcrumbs 'Base', 'Trial Session Requests', '1'
    expect(trial_session_request).to have_headline '1'

    within dom_id_selector(@trial_session_request) do
      within '.lead' do
        expect(trial_session_request).to have_css 'h2', text: 'Some lead title'
        expect(trial_session_request).to have_content 'And some lead stuff'
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{other_trial_session_request.id}'][title='Some cool other trial_session_request']", text: 'some alt'
      end

      within '.content' do
        expect(trial_session_request).to have_css 'h2', text: 'Some content title'
        expect(trial_session_request).to have_content 'And some content stuff'
        expect(trial_session_request).to have_css "img[alt='Content image'][src='#{@trial_session_request.images.last.file.url}']"
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{other_trial_session_request.id}']", text: 'Some cool other trial_session_request'
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{other_trial_session_request.id}'][title='Some cool other trial_session_request']", text: 'some alt'
      end

      within '.notes' do
        expect(trial_session_request).to have_css 'h2', text: 'Notes'
        expect(trial_session_request).to have_css 'h3.h2', text: 'Some notes title'
        expect(trial_session_request).to have_content 'And some notes stuff'
        expect(trial_session_request).to have_css "img[alt='Notes image'][src='#{@trial_session_request.images.last.file.url}']"
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{other_trial_session_request.id}']", text: 'Some cool other trial_session_request'
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{other_trial_session_request.id}'][title='Some cool other trial_session_request']", text: 'some alt'
      end

      within '.browsing' do
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{parent_trial_session_request.id}']", text: 'Previous trial_session_request: Cool parent trial_session_request'
        expect(trial_session_request).to have_css "a[href='/en/trial_session_requests/#{child_trial_session_request.id}']", text: 'Next trial_session_request: Really cool sub trial_session_request'
      end

      within '.additional_information' do
        expect(trial_session_request).to have_css '.creator', text: 'User test editor-name'
        expect(trial_session_request).to have_css '.created_at', text: 'Mon, 15 Jun 2015 14:33:52 +0200'
        expect(trial_session_request).to have_css '.updated_at', text: 'Mon, 15 Jun 2015 14:33:52 +0200'
      end

      within '.children' do
        expect(trial_session_request).to have_css 'h2', text: 'Sub trial_session_requests'
        expect(trial_session_request).to have_css 'h3', text: 'A cool sub trial_session_request'
        expect(trial_session_request).to have_css 'p', text: 'Some sub trial_session_request lead'
      end

      within '.pastables' do
        expect(trial_session_request).to have_css 'h2', text: 'Images (1)'
        # No codes available
      end

      within '.actions' do
        expect(trial_session_request).to have_css 'h2', text: 'Actions'

        expect(trial_session_request).to have_link 'Edit'
        expect(trial_session_request).to have_link 'Delete'
        expect(trial_session_request).to have_link 'Create Page'
        expect(trial_session_request).to have_link 'List of Pages'
      end
    end
  end

  it 'offers links to browse trial_session_request by trial_session_request (previous trial_session_request / next trial_session_request) like a book' do
    @root_1                 = create :trial_session_request, navigation_title: nil, title: 'Root 1',                 creator: @user
    @root_1_child_1         = create :trial_session_request, navigation_title: nil, title: 'Root 1 child 1',         creator: @user, parent: @root_1
    @root_1_child_2         = create :trial_session_request, navigation_title: nil, title: 'Root 1 child 2',         creator: @user, parent: @root_1
    @root_1_child_2_child_1 = create :trial_session_request, navigation_title: nil, title: 'Root 1 child 2 child 1', creator: @user, parent: @root_1_child_2
    @root_2                 = create :trial_session_request, navigation_title: nil, title: 'Root 2',                 creator: @user
    @root_2_child_1         = create :trial_session_request, navigation_title: nil, title: 'Root 2 child 1',         creator: @user, parent: @root_2

    visit trial_session_request_path(@root_1)
    expect(trial_session_request).to have_css '.previous[disabled]', text: 'No previous trial_session_request'
    expect(trial_session_request).to have_link 'Next trial_session_request: Root 1 child 1'

    click_link 'Next trial_session_request: Root 1 child 1'
    expect(trial_session_request).to have_link 'Previous trial_session_request: Root 1'

    click_link 'Next trial_session_request: Root 1'
    expect(trial_session_request).to have_link 'Previous trial_session_request: Root 1 child 1'

    click_link 'Next trial_session_request: Root 1 child 2 child 1'
    expect(trial_session_request).to have_link 'Previous trial_session_request: Root 1 child 2'

    click_link 'Next trial_session_request: Root 2'
    expect(trial_session_request).to have_link 'Previous trial_session_request: Root 1 child 2 child 1'

    click_link 'Next trial_session_request: Root 2 child 1'
    expect(trial_session_request).to have_link 'Previous trial_session_request: Root 2'
    expect(trial_session_request).to have_css '.next[disabled]', text: 'No next trial_session_request'
  end

  describe 'images' do
    it "doesn't display images if none available" do
      @trial_session_request = create :trial_session_request, creator: @user
      visit trial_session_request_path(@trial_session_request)

      expect(trial_session_request).not_to have_css '.images'
    end

    it 'displays images if available (if authorized)' do
      @trial_session_request = create :trial_session_request, images: [create(:image, creator: @user)], creator: @user
      visit trial_session_request_path(@trial_session_request)

      within '.images' do
        expect(trial_session_request).to have_css 'h2', text: 'Images (1)'

        within '#image_1' do
          expect(trial_session_request).to have_css ".image a[href='#{@trial_session_request.images.last.file.url}'] img[alt='Thumb image'][src='#{@trial_session_request.images.last.file.url(:thumb)}']"
          expect(trial_session_request).to have_css '.identifier',   text: 'Image test identifier'
          expect(trial_session_request).to have_css '.creator a',    text: 'User test editor-name'
          expect(trial_session_request).to have_css '.created_at',   text: 'Mon, 15 Jun 2015 14:33:52 +0200'
          expect(trial_session_request).to have_css '.updated_at',   text: 'Mon, 15 Jun 2015 14:33:52 +0200'
        end
      end

      login_as(create :user)
      visit trial_session_request_path(@trial_session_request)
      expect(trial_session_request).not_to have_css '.images'
    end
  end

  describe 'codes' do
    it "doesn't display codes if none available" do
      @trial_session_request = create :trial_session_request, creator: @user
      visit trial_session_request_path(@trial_session_request)

      expect(trial_session_request).not_to have_css '.codes'
    end

    it 'displays codes if available (if authorized)' do
      @trial_session_request = create :trial_session_request, codes: [create(:code, creator: @user)], creator: @user
      visit trial_session_request_path(@trial_session_request)

      within '.codes' do
        expect(trial_session_request).to have_css 'h2', text: 'Codes'

        within '#code_1' do
          expect(trial_session_request).to have_css '.identifier',   text: 'jmuheim-PipApO'
          expect(trial_session_request).to have_css '.title',        text: 'Code test title'
          expect(trial_session_request).to have_css '.url a',        text: 'https://codepen.io/jmuheim/pen/PipApO'
          expect(trial_session_request).to have_css '.creator a', text: 'User test editor-name'
          expect(trial_session_request).to have_css '.created_at',   text: 'Mon, 15 Jun 2015 14:33:52 +0200'
          expect(trial_session_request).to have_css '.updated_at',   text: 'Mon, 15 Jun 2015 14:33:52 +0200'
        end
      end

      login_as(create :user)
      visit trial_session_request_path(@trial_session_request)
      expect(trial_session_request).not_to have_css '.images'
    end
  end

  describe 'versioning' do
    it "doesn't display versions if none available" do
      @trial_session_request = create :trial_session_request, creator: @user
      visit trial_session_request_path(@trial_session_request)

      expect(trial_session_request).not_to have_css '.versions'
    end

    it 'displays versions if available (if authorized)', versioning: true do
      @trial_session_request = create :trial_session_request, creator: @user
      @trial_session_request.update_attributes! title: 'This is a new title',
                               lead:  'And a new lead'
      @trial_session_request.update_attributes! title:   'And another title',
                               content: 'And some other content'

      Mobility.with_locale(:de) do
        @trial_session_request.update_attributes! title:   'Und ein anderer Titel',
                                 content: 'Und ein anderer Inhalt'
      end

      visit trial_session_request_path(@trial_session_request)

      within '.versions' do
        expect(trial_session_request).to have_css 'h2', text: 'Versions (4)'

        within '#version_5_title_de' do
          expect(trial_session_request).to have_css '.count      .first_occurrence', text: 4
          expect(trial_session_request).to have_css '.event      .first_occurrence', text: 'Update'
          expect(trial_session_request).to have_css '.created_at .first_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Title (de)'
          expect(find('.value_before').text).to eq ''
          expect(trial_session_request).to have_css '.value_after',      text: 'Und ein anderer Titel'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_5_content_de' do
          expect(trial_session_request).to have_css '.count      .recurrent_occurrence', text: 4
          expect(trial_session_request).to have_css '.event      .recurrent_occurrence', text: 'Update'
          expect(trial_session_request).to have_css '.created_at .recurrent_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Content (de)'
          expect(find('.value_before').text).to eq ''
          expect(trial_session_request).to have_css '.value_after',      text: 'Und ein anderer Inhalt'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_4_title_en' do
          expect(trial_session_request).to have_css '.count      .first_occurrence', text: 3
          expect(trial_session_request).to have_css '.event      .first_occurrence', text: 'Update'
          expect(trial_session_request).to have_css '.created_at .first_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Title'
          expect(trial_session_request).to have_css '.value_before',     text: 'This is a new title'
          expect(trial_session_request).to have_css '.value_after',      text: 'And another title'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_4_content_en' do
          expect(trial_session_request).to have_css '.count      .recurrent_occurrence', text: 3
          expect(trial_session_request).to have_css '.event      .recurrent_occurrence', text: 'Update'
          expect(trial_session_request).to have_css '.created_at .recurrent_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Content'
          expect(trial_session_request).to have_css '.value_before',     text: 'Page test content'
          expect(trial_session_request).to have_css '.value_after',      text: 'And some other content'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_3_title_en' do
          expect(trial_session_request).to have_css '.count      .first_occurrence', text: 2
          expect(trial_session_request).to have_css '.event      .first_occurrence', text: 'Update'
          expect(trial_session_request).to have_css '.created_at .first_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Title'
          expect(trial_session_request).to have_css '.value_before',     text: 'Page test title'
          expect(trial_session_request).to have_css '.value_after',      text: 'This is a new title'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_3_lead_en' do
          expect(trial_session_request).to have_css '.count      .recurrent_occurrence', text: 2
          expect(trial_session_request).to have_css '.event      .recurrent_occurrence', text: 'Update'
          expect(trial_session_request).to have_css '.created_at .recurrent_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Lead'
          expect(trial_session_request).to have_css '.value_before',     text: 'Page test lead'
          expect(trial_session_request).to have_css '.value_after',      text: 'And a new lead'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_2_notes' do
          expect(trial_session_request).to have_css '.count      .recurrent_occurrence', text: 1
          expect(trial_session_request).to have_css '.event      .recurrent_occurrence', text: 'Create'
          expect(trial_session_request).to have_css '.created_at .recurrent_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Notes'
          expect(find('.value_before').text).to eq ''
          expect(trial_session_request).to have_css '.value_after',      text: 'Page test notes'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_2_title_en' do
          expect(trial_session_request).to have_css '.count      .first_occurrence', text: 1
          expect(trial_session_request).to have_css '.event      .first_occurrence', text: 'Create'
          expect(trial_session_request).to have_css '.created_at .first_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Title'
          expect(find('.value_before').text).to eq ''
          expect(trial_session_request).to have_css '.value_after',      text: 'Page test title'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_2_navigation_title_en' do
          expect(trial_session_request).to have_css '.count      .recurrent_occurrence', text: 1
          expect(trial_session_request).to have_css '.event      .recurrent_occurrence', text: 'Create'
          expect(trial_session_request).to have_css '.created_at .recurrent_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Navigation title'
          expect(find('.value_before').text).to eq ''
          expect(trial_session_request).to have_css '.value_after',      text: 'Page test navigation title'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end

        within '#version_2_content_en' do
          expect(trial_session_request).to have_css '.count      .recurrent_occurrence', text: 1
          expect(trial_session_request).to have_css '.event      .recurrent_occurrence', text: 'Create'
          expect(trial_session_request).to have_css '.created_at .recurrent_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.attribute',        text: 'Content'
          expect(find('.value_before').text).to eq ''
          expect(trial_session_request).to have_css '.value_after',      text: 'Page test content'
          expect(trial_session_request).to have_css '.value_difference', text: 'No diff view available (please activate JavaScript)'
        end
      end

      login_as(create :user)
      visit trial_session_request_path(@trial_session_request)
      expect(trial_session_request).not_to have_css '.versions'
    end

    it 'displays empty versions if available', versioning: true do
      @trial_session_request = create :trial_session_request, creator: @user
      @trial_session_request.versions.last.update_attribute :object_changes, nil

      visit trial_session_request_path(@trial_session_request)

      within '.versions' do
        expect(trial_session_request).to have_css 'h2', text: 'Versions (1)'

        within '#version_2' do
          expect(trial_session_request).to have_css '.count      .first_occurrence', text: 1
          expect(trial_session_request).to have_css '.event      .first_occurrence', text: 'Create'
          expect(trial_session_request).to have_css '.created_at .first_occurrence', text: 'Mon, 15 Jun 2015 14:33:52 +0200'

          expect(trial_session_request).to have_css '.no_changes', text: 'No changes in this version'
        end
      end
    end

    it "generates a diff view", versioning: true, js: true do
      @trial_session_request = create :trial_session_request, creator: @user
      visit trial_session_request_path(@trial_session_request)

      expect(trial_session_request.html).to include '<pre data-diff-result=""><ins style="background:#e6ffe6;">Page test title</ins></pre>'
    end
  end
end
