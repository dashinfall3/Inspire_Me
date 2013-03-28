class PhotosWorker
	include Sidekiq::Worker
	include CarrierWave::MimeTypes

	sidekiq_options retry: false

	def perform()
    	# process :fix_exif_rotation
		
		version :thumb do
			process :resize_to_fill => [50, 50]
		end
	end
end