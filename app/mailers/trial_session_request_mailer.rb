class TrialSessionRequestMailer < ApplicationMailer
  helper MarkdownHelper

  def thank_you(trial_session_request)
    @trial_session_request = trial_session_request

    I18n.with_locale(@trial_session_request.language) do
      mail(to: "\"#{@trial_session_request.name}\" <#{@trial_session_request.email}>", subject: t('.subject'))
    end
  end

  def new_request(trial_session_request)
      @trial_session_request = trial_session_request
      mail(to: "Accessibility-Doctor.com <help@accessibility-doctor.com>", subject: t('.subject'))
  end
end
