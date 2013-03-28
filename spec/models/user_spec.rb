require 'spec_helper'

describe User do
  
  it { should have_db_column(:username) }
  it { should have_db_column(:email) }
  it { should have_db_column(:votes_count) }

  it { should validate_confirmation_of(:password) }
  it { should ensure_length_of(:password).is_at_least(8) }
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should allow_value("omar@omar.com").for(:email) }
  it { should_not allow_value("blah").for(:email) }

  it { should have_many(:photos) }

  context 'user needs to be in db' do
    let(:user) { create :user }
    it { should validate_uniqueness_of(:email) }  
  end

  context 'after save' do 
    let(:user) { create :user, { :email => 'CAP@email.com' } }
    it 'should not save the email with capital letter' do
      user.email.should_not match(/[A-Z]/)
    end
  end

  describe '#admins' do
    before { 5.times { create :user} }

    it 'should return an ActiveRecord::Relation' do
      User.admins.class.should eq(ActiveRecord::Relation)
    end

    it 'should return User objects' do
      User.admins.each { |user| user.class.should eq(User) }
    end

    it 'should return User objects where admin is true' do
      User.admins.each { |user| user.admin.should be_true }
    end

    it 'should return 5 User objects' do
      User.admins.count.should eq(5)
    end
  end

  describe '#add_as_participant' do
    let(:user) { create :user }
    let(:photo) { create :photo }
    before { Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png") } 

    it 'takes one argument' do
      User.public_instance_method(:add_as_participant).arity.should eq(1)
    end

    it 'returns an InspirationUser' do
      user.add_as_participant(photo).should be_a(InspirationUser)
    end

    it 'photo_id equals the arguments id' do
      inspiration_user = user.add_as_participant(photo)
      inspiration_user.photo_id.should eq(photo.id)
    end

    it 'user_id equals the users id on which the method was called' do
      inspiration_user = user.add_as_participant(photo)
      inspiration_user.user_id.should eq(user.id)
    end

    it "inspiration_id equals the argument's inspiration's id " do
      inspiration_user = user.add_as_participant(photo)
      inspiration_user.inspiration_id.should eq(photo.inspiration.id)
    end

  end

  describe '#admin?' do
    let(:user_admin_true) { build :user, :admin => true }
    let(:user_admin_false) { build :user, :admin => false }

    it 'returns true or false' do  
      user_admin_true.admin?.should eq(true)
      user_admin_false.admin?.should eq(false)
    end
    
  end

  describe '#regular' do
    let(:user_admin_true) { build :user, :admin => true }
    let(:user_admin_false) { build :user, :admin => false }

    it 'returns true or false' do  
      user_admin_true.regular.should eq(false)
      user_admin_false.regular.should eq(true)
    end
  end

  describe '#voted_on?(photo)' do
    before do 
      Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
    end
    let!(:vote) { create :vote }
    let(:user) { create :user }
    let(:photo) { create :photo }

    it 'takes one argument' do
      User.public_instance_method(:voted_on?).arity.should eq(1)
    end

    it 'returns true if user has voted' do
      user  = vote.voter
      photo = vote.photo
      user.voted_on?(photo).should eq(true)
    end

    it 'returns false if user has not voted' do
      user.voted_on?(photo).should eq(false)
    end

  end

end
