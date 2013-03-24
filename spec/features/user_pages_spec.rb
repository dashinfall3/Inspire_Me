require 'spec_helper'

#Can you see link to 'my profile'
#If you click, does it show your name on user's show page

describe 'User pages' do

  subject { page }

  describe 'Signing up' do
    before { visit new_user_registration_path }

    describe 'with valid information' do

      before do
        fill_in('user_username'             , :with => 'BraydenCleary')
        fill_in('user_email'                , :with => 'brayden@cleary.com')
        fill_in('user_password'             , :with => 'password1234')
        fill_in('user_password_confirmation', :with => 'password1234')
        Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
        create :inspiration
        create :photo
      end

      it 'should create a user' do  
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
      end

      describe 'after saving a user' do
        before { click_button 'Sign up' }

        it { should have_content 'Profile'}
        it { should have_content 'Logout'}
        it { should have_content 'Add Inspiration'}
        it { should have_content 'Welcome! You have signed up successfully.'}
      end

    end

    describe 'with invalid information' do

      it 'should not create a user' do
        expect { click_button 'Sign up'}.not_to change(User, :count)
      end

      describe 'errors' do
        before { click_button 'Sign up' }

        it { should have_content 'errors'}
        it { should have_selector('div#error_explanation') }
      end

    end

  end


  describe 'Logging In' do
    before do
      visit new_user_session_path 
    end
    let(:user) { create :user }

    describe 'with valid information' do

      before do
        fill_in('user_email', :with => user.email )
        fill_in('user_password', :with => user.password )
        Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
        create :inspiration
        create :photo
      end

      describe 'after signing in' do
        before { click_button 'Sign in'}

        it { should have_content 'Profile'}
        it { should have_content 'Logout'}
        it { should have_content 'Add Inspiration'}
        it { should have_content 'Signed in successfully.'}
      end

    end

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_content 'Invalid email or password.'}

    end
  end



end
