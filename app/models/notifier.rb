class Notifier < ActionMailer::Base
  default :from => "team@inspireme.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def daily_inspiration_email(user, inspiration)
  	@inspiration = inspiration
    mail( :to => user.email,
    :subject => "Daily inspiration: Let's create something beautiful together today." )
  end

  def daily_mural_email(user, inspiration)
    @inspiration = inspiration
    mail( :to => user.email,
        :subject => "See what the world made today." )
  end

  def create_inspiration(user, inspiration)
    @inspiration = inspiration
    mail( :to => user.email,
        :subject => "Inspire your friends." )
  end

end
