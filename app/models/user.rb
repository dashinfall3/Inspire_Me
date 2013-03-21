class User < ActiveRecord::Base

  has_many :photos
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

  private

  def downcase_email!
    self.email.downcase!
  end

end
