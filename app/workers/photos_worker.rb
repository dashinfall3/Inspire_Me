class PhotosWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform()
    	process :fix_exif_rotation
		#Process files as they are uploaded:
		process :resize_to_limit => [500, 500]
		version :thumb do
			process :resize_to_fill => [50, 50]
		end
	end
end