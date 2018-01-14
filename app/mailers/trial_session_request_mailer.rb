class TrialSessionRequestMailer < ApplicationMailer
  def thank_you_email(user)
    @user = user
    mail(to: "\"#{@user.name}\" <#{@user.email}>", subject: 'Welcome to My Awesome Site')
  end
end
