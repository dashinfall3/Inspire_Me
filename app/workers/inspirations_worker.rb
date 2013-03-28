class InspirationsWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform()
    inspiration = Inspiration.current_master_inspiration
    User.all.each do |user|
      Notifier.daily_inspiration_email(user, inspiration).deliver
    end
	end
end