class User < ActiveRecord::Base

  has_many :photos
  has_many :inspiration_users
  has_many :inspirations, :through => :inspiration_users
  has_many :inspirations_created, :class_name => 'Inspiration', :foreign_key => 'creator_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  validates :username, :presence => true

  validates :email, :uniqueness => { :case_sensitive => false }

  before_save :downcase_email!

  scope :admins, where(:admin => true)

  def add_as_participant(photo)
    InspirationUser.create(:user_id => self.id, :inspiration_id => photo.inspiration.id, :photo_id => photo.id)
  end

  def admin?
    self.admin == true
  end

  def regular
    self.admin == false
  end

  private

  def downcase_email!
    self.email.downcase!
  end

end
