class UserMailer < ActionMailer::Base
  
  def invitation_mail(user)
    @user = user
    mail :to => @user.email, :subject => t('user_mailer.invitation_mail')
  end
  
end