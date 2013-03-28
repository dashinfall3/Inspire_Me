class Photo < ActiveRecord::Base
  attr_accessible :image, :caption, :inspiration_id

  has_many :votes
  belongs_to :inspiration 
  belongs_to :user

  validates :caption, :length => {:maximum => 140}

  mount_uploader :image, ImageUploader
end
