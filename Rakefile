#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

InspireMe::Application.load_tasks



task :daily_inspiration => :environment do
  Inspiration.daily_inspiration
end

task :daily_mural => :environment do
  Inspiration.daily_mural
end
