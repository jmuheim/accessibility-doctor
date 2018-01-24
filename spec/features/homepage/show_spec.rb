require 'rails_helper'

describe 'Showing the home page' do
  before { visit root_path }

  it 'displays a welcome message' do
    expect(page).to have_title 'Welcome to Accessibility Doctor!'
    expect(page).to have_breadcrumbs 'A11y-Doc'
    expect(page).to have_headline 'Welcome Accessibility Doctor!'
  end
end
