class Photo < ActiveRecord::Base
  belongs_to :inspiration 
  attr_accessible :image, :name
  mount_uploader :image, ImageUploader
end
