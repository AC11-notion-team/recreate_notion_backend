class ApplicationMailer < ActionMailer::Base
  default from: 'postmaster@zettel.tw'
  layout 'mailer'
end
