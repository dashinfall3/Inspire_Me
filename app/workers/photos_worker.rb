class PhotosWorker
	include Sidekiq::Worker

	sidekiq_options :retry => false

	def perform(photo_id)
		photo = Photo.find(photo_id)
		photo.update_attribute :key, params[:key]
		# download image from S3
		photo.image = #something here I'm not sure what
		photo.in_progress = false
		photo.save
	end
end
