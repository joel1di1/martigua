class UserMailer < ActionMailer::Base
  
  def invitation_mail(user)
    @user = user
    mail :to => @user.email, :subject => t('user_mailer.invitation_mail')
  end

  def ask_for_availability(matches, user)
    @matches = matches
    @user = user

    mail :to => @user.email, :subject => "Dispo pour les matchs du #{Match.schedule_for(@matches)}"
  end
  
end