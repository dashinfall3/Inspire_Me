class PhotosWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform()
		include CarrierWave::MimeTypes

    	process :fix_exif_rotation
		
		version :thumb do
			process :resize_to_fill => [50, 50]
		end
	end
end