class InspirationsWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(inspiration_id)
		#put daily emailing code here
		inspiration = Inspiration.find(inspiration_id)
	end

end