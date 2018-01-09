require 'rails_helper'

RSpec.describe "LiveSessions", type: :request do
  describe "GET /live_sessions" do
    it "works! (now write some real specs)" do
      get live_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
