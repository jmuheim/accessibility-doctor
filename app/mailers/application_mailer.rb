class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer_from
  layout 'mailer'
end

