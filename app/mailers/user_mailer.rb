class UserMailer < ActionMailer::Base
  default :from => "postmaster@zettel.tw"

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "#{@user.confirm_token} Registration Confirmation")
  end
end
