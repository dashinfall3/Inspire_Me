class Photo < ActiveRecord::Base
  belongs_to :inspiration 
  attr_accessible :image, :caption
  mount_uploader :image, ImageUploader
end
