class Notifier < ActionMailer::Base
  default :from => "signup@inspireme.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def daily_inspiration_email(user, inspiration)
  	@inspiration = inspiration
    mail( :to => user.email,
    :subject => "Inspiration Email" )
  end

  def daily_mural_email(user, inspiration)
    @inspiration = inspiration
    mail( :to => user.email,
        :subject => "Mural Email" )
  end

end
