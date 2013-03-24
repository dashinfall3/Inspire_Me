class Inspiration < ActiveRecord::Base
  PENDING = 0 
  LIVE = 1
  COMPLETE = 2
  
  attr_accessible :content, :status
  validates :content, :presence => true,
                      :length => { :maximum => 140 },
                      :uniqueness => true
  validates :status, :presence => true

  has_many :photos
  has_many :inspiration_users
  has_many :users, :through => :inspiration_users
  belongs_to :creator, :class_name => "User"

  scope :pending, where(:status => PENDING)
  scope :live, where(:status => LIVE)

  
  def self.daily_inspiration
  	inspiration = Inspiration.current_master_inspiration

  	User.all.each do |user|
  		Notifier.daily_inspiration_email(user, inspiration).deliver
  	end

    #send your emails to all users using sidekiq
  	#InspirationsWorker.perform_async(@inspiration.id)
  end

  def self.daily_mural
    inspiration = Inspiration.current_master_inspiration

    User.all.each do |user|
      Notifier.daily_mural_email(user, inspiration).deliver
    end

    #send your emails to all users using sidekiq
    #InspirationsWorker.perform_async(@inspiration.id)
  end

  def self.update_current_master_inspiration
    if Inspiration.admin_inspirations.pending.any?
      Inspiration.admin_inspirations.pending.first.update_attribute(:status, LIVE)
      Inspiration.complete_old_master_inspiration
    end
  end

  def self.complete_old_master_inspiration
    if Inspiration.admin_inspirations.live.length > 1
      Inspiration.admin_inspirations.live.first.update_attribute(:status, COMPLETE)
    end
  end

  def self.current_master_inspiration
    Inspiration.admin_inspirations.where(:status => LIVE).first 
  end

  def self.admin_inspirations
    Inspiration.where(:creator_id => User.admins)
  end





end
