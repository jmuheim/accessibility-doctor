require 'rails_helper'

describe 'Deleting trial session request' do
  before do
    @user = create :user, role: 'admin'
    @trial_session_request = create :trial_session_request
  end

  before { login_as(create :user, :admin) }

  it 'deletes a trial session request' do
    expect {
      visit_delete_path_for(@trial_session_request)
    }.to change { TrialSessionRequest.count }.by -1

    expect(page).to have_flash 'Trial Session Request was successfully destroyed.'
  end
end
