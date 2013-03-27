require 'spec_helper'

describe 'Photo Pages' do
	describe 'Show page' do
		let(:user) { create :user }
		before do
		  Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
		  create :inspiration
		  @photo = create :photo, :user => user
		end

		context 'when user is not signed in' do
			before {visit photo_path(@photo)}

			it 'doesnt have option to vote' do
				page.should_not have_selector("form[action='#{votes_path}'][method='post']")
			end

		end

		context 'when user is signed in' do
			before do
			 	login_as(user)
			 	visit photo_path(@photo)
			end

			it 'has option to vote' do
				page.should have_selector("form[action='#{votes_path}'][method='post']")
			end
		end

		context 'regardless of user signin status' do
			before { visit photo_path(@photo)}

			it 'displays vote count' do
				page.should have_css('.vote-count', text: 'Vote Count:')
			end

			it 'displays creators username' do
				page.should have_content(@photo.user.username)
			end

			it 'has link to creators profile' do
				page.should have_link_to(user_path(user))
			end
		end
		
	end
end
