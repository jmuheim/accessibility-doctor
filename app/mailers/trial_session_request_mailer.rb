class TrialSessionRequestMailer < ApplicationMailer
  helper MarkdownHelper
  helper ApplicationHelper

  def thank_you_email(trial_session_request)
    @trial_session_request = trial_session_request
    mail(to: "\"#{@trial_session_request.name}\" <#{@trial_session_request.email}>", subject: t('.thank_you.subject'))
  end
end
