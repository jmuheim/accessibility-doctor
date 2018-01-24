# Preview all emails at http://localhost:3000/rails/mailers/trial_session_request_mailer
class TrialSessionRequestMailerPreview < ActionMailer::Preview
  def thank_you
    TrialSessionRequestMailer.thank_you(TrialSessionRequest.last)
  end

  def new_request
    TrialSessionRequestMailer.new_request(TrialSessionRequest.last)
  end
end
