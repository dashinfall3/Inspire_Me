class Inspiration < ActiveRecord::Base
  attr_accessible :content
  validates :content, :uniqueness => true
  validates :content, :presence => true

  has_many :photos
end
