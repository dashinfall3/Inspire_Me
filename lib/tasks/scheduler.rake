desc "This task is called by the Heroku scheduler add-on"
task :send_inspiration => :environment do
  puts "Updating feed..."
  Inspiration.daily_inspiration
  puts "done."
end

task :send_mural => :environment do
	# Inspiration.daily_inspiration
  #run a model method here
end