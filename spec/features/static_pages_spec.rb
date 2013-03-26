require 'spec_helper'

describe 'Static pages' do
  describe "Index page" do
    before { Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png") }
    let!(:inspiration) { create :inspiration }
    let!(:photo) { create :photo }

    context 'user is not signed in' do 
      it "should not have profile link" do     
        visit root_path
        page.should_not have_content('Profile')
        page.should have_content('Log in')
        page.should have_content('Sign up')
      end
    end

    context 'user is signed in' do
      let(:user) { create :user }
      before do
        visit new_user_session_path
        fill_in('user_email', :with => user.email )
        fill_in('user_password', :with => user.password )
        Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
        create :inspiration
        create :photo
        click_button('Sign in')
      end

      it 'should have option to upload photo' do
        page.should have_select('button', 'Add Photo')
      end
    end
  end
end
