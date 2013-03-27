require 'spec_helper'

#Can you see link to 'my profile'
#If you click, does it show your name on user's show page

describe 'User pages' do
  describe 'Signing up' do
    before { visit new_user_registration_path }

    context "when given valid information" do

      before do
            Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")

        CarrierWave::Mount::Mounter.any_instance.stub(:store!)
        user = attributes_for(:user)
        @email = user[:email]

        fill_in('user_username', :with => user[:username])
        fill_in('user_email',    :with => user[:email])

        fill_in('user_password', :with => user[:password])
        fill_in('user_password_confirmation', :with => user[:password])

        Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
        create :inspiration
        create :photo
      end

      it "creates a new user" do
        expect {
          click_button 'Sign up'
        }.to change(User, :count).by(1)
      end

      describe 'after saving a user' do
        before { click_button 'Sign up' }
        let(:user) { User.find_by_email(@email) }
        let(:navigation) { page.find('header > ul') }

        it "contains a link to the current user's profile" do
          navigation.should have_link_to(user_path(user))
        end

        it "contains a logout link" do
          navigation.should have_link_to(destroy_user_session_path)
        end

        it "contains a link to add a new inspiration" do
          navigation.should have_link_to(new_inspiration_path)
        end

        it "should display a welcome message" do
          page.should have_content "Welcome!"
        end
      end
    end

    describe 'with invalid information' do
      it 'should not create a user' do
        expect {
          click_button 'Sign up'
        }.not_to change(User, :count)
      end

      describe 'errors' do
        subject { page }

        before { click_button 'Sign up' }

        it { should have_content 'errors'}
        it { should have_selector('div#error_explanation') }
      end
    end
  end


  describe 'Logging In' do
    before { visit new_user_session_path }
    let(:user) { create(:user) }

    describe 'with valid information' do
      before do
        fill_in('user_email', :with => user.email )
        fill_in('user_password', :with => user.password )
        Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
        create :inspiration
        create :photo
      end

      describe 'after saving a user' do
        before { click_button 'Sign in' }
        let(:navigation) { page.find('header > ul') }

        it "contains a link to the current user's profile" do
          navigation.should have_link_to(user_path(user))
        end

        it "contains a logout link" do
          navigation.should have_link_to(destroy_user_session_path)
        end

        it "contains a link to add a new inspiration" do
          navigation.should have_link_to(new_inspiration_path)
        end
      end
    end

    describe 'with invalid information' do
      subject { page }
      before { click_button 'Sign in' }

      it { should have_content 'Invalid email or password.'}
    end
  end

  describe 'Show page' do
    before do
      Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
      @photo = create :photo 
      @inspiration =  @photo.inspiration 
      @user = @photo.user 
      @user2 = create :user 
      login_as(@user)
    end

    context 'when visiting my show page' do
      before { visit user_path(@user) }
      
      it "displays the title 'My Inspirely Profile'" do
        page.should have_content("My Inspirely Profile")
      end

    end

    context "when visiting other user's show page" do
      before { visit user_path(@user2) }

      it "displays the name of the user" do
        page.should have_content(@user2.username)
      end

    end

    context 'independent of profile' do
      before { visit user_path(@user) }

      it "displays the correct number of inspiration replies" do
        count = page.find("span[id='count']")
        count.text.to_i.should eq(@user.photos.count)
      end

    end

  end

end
