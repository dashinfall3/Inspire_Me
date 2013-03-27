require 'spec_helper'

describe Vote do

	it { should have_db_column(:photo_id) }
	it { should have_db_column(:voter_id) }

	it { should belong_to(:photo) }
	it { should belong_to(:voter) }

	it { should validate_presence_of(:photo_id) }
	it { should validate_presence_of(:voter_id) }

	context 'vote must be unique' do
		before { Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png") }
		let!(:vote) { create :vote }
		it { should validate_uniqueness_of(:voter_id).scoped_to(:photo_id) }
	end

end