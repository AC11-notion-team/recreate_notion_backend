class SharepagesMailer < ActionMailer::Base
  default :from => "postmaster@zettel.tw"
  def sharepage_link(user,page)
    @user = user
    @page = page
    mail(
      to: @user.email, 
      subject: @page.title
    )
  end
end
