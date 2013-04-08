class User < ActiveRecord::Base

  has_many :photos
  has_many :inspiration_users
  has_many :inspirations, :through => :inspiration_users
  has_many :inspirations_created, :class_name => 'Inspiration', :foreign_key => 'creator_id'
  has_many :votes, :foreign_key => 'voter_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :provider, :uid, :photo_url, :gender, :location
  validates :username, :presence => true

  validates :email, :uniqueness => { :case_sensitive => false }

  before_save :downcase_email!

  scope :admins, where(:admin => true)
  scope :subscribed, where(:subscription_status => 0)
  scope :unsubscribed, where(:subscription_status => 1)

  def add_as_participant(photo)
    InspirationUser.create(:user_id => self.id, :inspiration_id => photo.inspiration.id, :photo_id => photo.id)
  end

  def admin?
    self.admin == true
  end

  def regular
    self.admin == false
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           photo_url:auth.info.image,
                           gender:auth.extra.raw_info.gender,
                           location:auth.info.location
                           )
    end
    user
  end

  def voted_on?(photo)
    photo.votes.where(:voter_id => self.id).any?
  end

  private

  def downcase_email!
    self.email.downcase!
  end

end
