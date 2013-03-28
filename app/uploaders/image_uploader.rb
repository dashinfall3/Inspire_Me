require 'carrierwave/processing/mini_magick'
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include CarrierWaveDirect::Uploader
  
  process :set_content_type

  def fix_exif_rotation
    manipulate! do |img|
      img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :fix_exif_rotation
  process :resize_to_limit => [500, 500]

  version :thumb do
    process :resize_to_fill => [50, 50]
  end
end
