require 'spec_helper'

describe Inspiration do

  it { should have_db_column(:content) }
  it { should respond_to(:content) }

  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_most(140) }

  it { should have_many(:photos) }

  context 'has unique content' do
    let(:inspiration) { create :inspiration }
    it { should validate_uniqueness_of(:content) }
  end

  describe '#admin_inspirations' do
    before { 5.times { create :inspiration } }

    it 'doesnt take an argument' do
      Inspiration.method(:admin_inspirations).arity.should eq(0)
    end

    it 'returns an ActiveRecord::Relation' do
      Inspiration.admin_inspirations.class.should eq(ActiveRecord::Relation)
    end

    it 'returns Inspiration objects created by admins' do
      Inspiration.admin_inspirations.each do |inspiration|
        User.find(inspiration.creator_id).admin.should eq(true)
      end
    end
  end

  describe '#current_master_inspiration' do
    before { 5.times { create :inspiration, :status => 1} }

    it 'doesnt take an argument' do
      Inspiration.method(:current_master_inspiration).arity.should eq(0)
    end

    it 'returns an Inspiration object' do
      Inspiration.current_master_inspiration.should be_kind_of(Inspiration)
    end

    it 'returns an Inspiration object whose status is live' do
      Inspiration.current_master_inspiration.status.should eq(1)
    end
  end

  describe '#complete_old_master_inspiration' do

    it 'doesnt take an argument' do
      Inspiration.method(:complete_old_master_inspiration).arity.should eq(0)
    end

    context 'more than 1 live admin inspirations' do
      let!(:inspiration1) { create :inspiration, :status => 1 }
      let!(:inspiration2) { create :inspiration, :status => 1 }
      let!(:inspiration3) { create :inspiration, :status => 1 }

      it "changes the first live admin inspiration's status to complete" do
        Inspiration.complete_old_master_inspiration #BUGBUG Ask about this!
        inspiration1.reload
        inspiration1.status.should eq(2)
      end 

    end

    context 'less than 1 live admin inspirations' do

      it 'returns nil' do
        Inspiration.complete_old_master_inspiration.should eq(nil)
      end

    end

  end

  describe '#update_current_master_inspiration' do

    context 'when there are more than 1 admin inspirations pending and more than 1 live' do
      let!(:inspiration1) { create :inspiration }
      let!(:inspiration2) { create :inspiration }
      let!(:inspiration3) { create :inspiration }
      let!(:inspiration4) { create :inspiration, :status => 1}
      let!(:inspiration5) { create :inspiration, :status => 1}

      it 'updates the first admin pending inspiration to live' do
        Inspiration.update_current_master_inspiration
        inspiration1.reload
        inspiration1.status.should eq(1)
      end

      it 'changes the current live inspiration to complete' do
        Inspiration.update_current_master_inspiration
        inspiration4.reload
        inspiration4.status.should eq(2)
      end

    end

    context 'when there is 1 admin inspiration pending, 0 live' do
      let!(:inspiration) { create :inspiration }

      xit 'updates the first pending inspiration to live' do
        Inspiration.update_current_master_inspiration
        inspiration1.reload
        inspiration1.status.should eq(1)
      end

    end

    context 'where are 0 admin inspirations pending and 1 live' do
      let!(:inspiration) { create :inspiration, :status => 1 }

      it 'stays live' do
        Inspiration.update_current_master_inspiration
        inspiration.status.should eq(1)
      end
    end

    context 'when there are 0 admin inspirations pending' do

      it 'returns nil' do
        Inspiration.update_current_master_inspiration.should eq(nil)
      end

    end

  end

  describe '#photo_count' do
    before do 
      Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
      photo = create :photo 
      @inspiration = photo.inspiration
    end

    it 'returns the number of photos associated with an inspiration' do
      @inspiration.photo_count.should eq(1)
    end

  end

  describe '#photo_by_user(user)' do
    before do
      Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")  
      photo = create :photo
      @user = photo.user
      @inspiration = photo.inspiration     
    end

    it 'should return an Active Record Relation' do
      @inspiration.photo_by_user(@user).class.should eq(ActiveRecord::Relation)
    end

    it 'should return photo objects' do
      @inspiration.photo_by_user(@user).each do |photo|
        photo.class.should eq(Photo)
      end
    end

    it 'should return the correct number of photos' do
      @inspiration.photo_by_user(@user).count.should eq(1)
    end
  end
  
end
