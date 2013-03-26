class Vote < ActiveRecord::Base
	attr_accessible :photo_id
	belongs_to :photo
	belongs_to :voter, :class_name => "User"
	belongs_to :user, :counter_cache => true

	validates :photo_id, :presence => true
	validates :voter_id, :presence => true
end