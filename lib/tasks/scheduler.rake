desc "This task is called by the Heroku scheduler add-on"

task :daily_inspiration => :environment do
  Inspiration.daily_inspiration
end

task :daily_mural => :environment do
  Inspiration.daily_mural
end

task :update_current_master_inspiration => :environment do
  Inspiration.update_current_master_inspiration
end
