# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
InspireMe::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "app13808527@heroku.com",
  :password => "dxw3tsqt",
  :domain => "http://www.frozen-cove-1468.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
