class Photo < ActiveRecord::Base
  belongs_to :inspiration 
  belongs_to :user
  has_many :votes
  attr_accessible :image, :caption, :inspiration_id
  mount_uploader :image, ImageUploader
  validates :caption, :length => {:maximum => 140}
  validates_presence_of :image
end
