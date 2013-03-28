source 'http://rubygems.org'

gem 'rails', '3.2.11' 

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'carrierwave_direct'
gem 'mini_magick'
gem 'devise'
gem 'fog'
gem 'pg'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'unicorn'
gem 'debugger'
gem 'font-awesome-sass-rails'
gem 'redis'

gem 'jquery-rails'


# For Sidekiq and Sidekiq admin
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', require: false
gem 'slim'

group :development do
  gem 'quiet_assets'
  gem 'foreman'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'bootstrap-sass'
  gem "twitter-bootstrap-rails"
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :test do
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end
