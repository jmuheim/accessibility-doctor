require 'rails_helper'

describe TrialSessionRequestsController do
  context 'creating a trial session request' do
    context 'trial session request valid' do
      it 'sends a "Thank you" email to the requester' do
        expect_any_instance_of(TrialSessionRequestMailer).to receive(:thank_you).with instance_of TrialSessionRequest
        post :create, params: {trial_session_request: attributes_for(:trial_session_request)}
      end

      it 'sends a "New request" email to the admin' do
        expect_any_instance_of(TrialSessionRequestMailer).to receive(:new_request).with instance_of TrialSessionRequest
        post :create, params: {trial_session_request: attributes_for(:trial_session_request)}
      end
    end

    context 'trial session request invalid' do
      it "doesn't send a 'Thank you' email to the admin" do
        expect_any_instance_of(TrialSessionRequestMailer).not_to receive(:thank_you)
        post :create, params: {trial_session_request: attributes_for(:trial_session_request).merge(name: nil)}
      end

      it "doesn't send a 'New request' email to the admin" do
        expect_any_instance_of(TrialSessionRequestMailer).not_to receive(:new_request)
        post :create, params: {trial_session_request: attributes_for(:trial_session_request).merge(name: nil)}
      end
    end
  end
end
