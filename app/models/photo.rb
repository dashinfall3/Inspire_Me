class Photo < ActiveRecord::Base
  belongs_to :inspiration 
  atr_accessible :image, :caption
  mount_uploader :image, ImageUploader
end
