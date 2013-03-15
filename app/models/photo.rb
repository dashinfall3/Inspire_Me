class Photo < ActiveRecord::Base
  belongs_to :inspiration 
  attr_accessible :image
  mount_uploader :image, ImageUploader
end
