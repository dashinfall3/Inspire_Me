class Photo < ActiveRecord::Base
  belongs_to :inspiration 
  belongs_to :user
  attr_accessible :image, :caption
  mount_uploader :image, ImageUploader
  validates :caption, :length => {:maximum => 140}

end
