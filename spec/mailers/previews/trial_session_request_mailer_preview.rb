# Preview all emails at http://localhost:3000/rails/mailers/trial_session_request_mailer
class TrialSessionRequestMailerPreview < ActionMailer::Preview
  def thank_you_email
    TrialSessionRequestMailer.thank_you_email(TrialSessionRequest.first)
  end
end
