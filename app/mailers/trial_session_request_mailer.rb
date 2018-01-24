class TrialSessionRequestMailer < ApplicationMailer
  def thank_you(trial_session_request)
    @trial_session_request = trial_session_request

    I18n.with_locale(@trial_session_request.language) do
      mail(to: "\"#{@trial_session_request.name}\" <#{@trial_session_request.email}>", subject: t('.subject'))
    end
  end

  def new_request(trial_session_request)
    @trial_session_request = trial_session_request
    mail(to: email_with_name(Rails.application.secrets.mailer_from), subject: "New request for a trial session by #{@trial_session_request.name} (#{@trial_session_request.company})")
  end
end
