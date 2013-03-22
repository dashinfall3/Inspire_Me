class Inspiration < ActiveRecord::Base
  attr_accessible :content, :status
  validates :content, :presence => true,
                      :length => { :maximum => 140 },
                      :uniqueness => true
  validates :status, :presence => true

  has_many :photos
  has_many :inspiration_users
  has_many :users, :through => :inspiration_users
  belongs_to :creator, :class_name => "User"

def self.daily_inspiration
	#send your emails to all users using sidekiq
	inspiration = Inspiration.first

	User.all.each do |user|
		Notifier.inspiration_email(user, inspiration).deliver
	end
	#InspirationsWorker.perform_async(@inspiration.id)
end

end
