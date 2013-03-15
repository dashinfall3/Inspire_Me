class Inspiration < ActiveRecord::Base
  attr_accessible :content
  validates :content, :presence => true,
                      :length => { :maximum => 140 },
                      :uniqueness => true

  has_many :photos
end
