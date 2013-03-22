class Inspiration < ActiveRecord::Base
  attr_accessible :content
  validates :content, :presence => true,
                      :length => { :maximum => 140 },
                      :uniqueness => true

  has_many :photos



def self.daily_inspiration
	#send your emails to all users using sidekiq
	inspiration = Inspiration.first

	User.all.each do |user|
		Notifier.inspiration_email(user, inspiration).deliver
	end
	#InspirationsWorker.perform_async(@inspiration.id)
end

end