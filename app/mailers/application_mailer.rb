class ApplicationMailer < ActionMailer::Base
  default from: "Accessibility-Doctor.com <help@accessibility-doctor.com>"
  layout 'mailer'
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

