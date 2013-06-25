class UserMailer < ActionMailer::Base
   

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
    default :from => "eifion@asciicasts.com"
  def message_confirmation(user,event)
        mail(:to => user.email, :subject => "Message Confirmation
        ")
  end
  def password_reset(user)
     @user=user
    mail(:to => user.email, :subject => "Password Reset Confirmation
        ")
  end
  def registration_confirmation(user)
   @user=user
    mail(:to => user.email, :subject => "Registered")
  end
  def signup_confirmation(user)
    @greeting = "Hi"
    @user=user
    mail to: user.email, subject: "Sign Up Confirmation"
  end
end
