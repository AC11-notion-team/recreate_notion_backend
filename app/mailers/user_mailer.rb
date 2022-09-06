class UserMailer < ActionMailer::Base
  default :from => "postmaster@sandbox5d0b99ad363746c0935198a150fa5e2c.mailgun.org"

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "#{@user.confirm_token} Registration Confirmation")
  end
end
