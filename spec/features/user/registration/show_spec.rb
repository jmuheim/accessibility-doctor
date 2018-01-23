require 'rails_helper'

describe 'Showing account' do
  context 'as a guest' do
    before { @user = create :user }

    it 'does not grant permission to show the account' do
      visit user_registration_path

      expect(page).to have_flash('You are not authorized to access this page.').of_type :alert
    end
  end

  context 'signed in as user' do
    before do
      @user = create :user, :with_avatar, :with_curriculum_vitae
      login_as(@user)
      visit user_registration_path
    end

    it 'displays the account' do
      expect(page).to have_title 'Welcome, User test name! - A11y-Doc'
      expect(page).to have_active_navigation_items 'User menu', 'Show account'
      expect(page).to have_breadcrumbs 'A11y-Doc', 'User test name'
      expect(page).to have_headline 'Welcome, User test name!'

      within dom_id_selector(@user) do
        expect(page).to have_content 'User test name'
        expect(page).to have_content 'user@example.com'
        expect(page).to have_css 'img[alt="User test name"]'
        expect(page).to have_link 'document.txt'
        expect(page).to have_link 'Edit'
      end
    end
  end
end
