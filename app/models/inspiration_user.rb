class InspirationUser < ActiveRecord::Base  
  attr_accessible :inspiration_id, :user_id, :photo_id 

  validates :user_id, :uniqueness => { :scope => :inspiration_id }
  validates :user_id, :inspiration_id, :presence => true

  belongs_to :user
  belongs_to :inspiration
end
