class Inspiration < ActiveRecord::Base
  attr_accessible :content
  validates :content, :presence => true,
                      :length => { :maximum => 140 },
                      :uniqueness => true

  has_many :photos
end


def self.daily_inspiration
	#send your emails to all users using sidekiq
	@inspiration = Inspiration.first

	#send email code heerrrre!!!!



	#InspirationsWorker.perform_async(@inspiration.id)
end
