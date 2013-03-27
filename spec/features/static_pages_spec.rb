require 'spec_helper'

describe 'Static pages' do
  describe "Index page" do
    before do
      Photo.any_instance.stub(:image => "https://s3.amazonaws.com/uploads/photo/image/1/logo-logged-in_4x-6a0620a1bd429fde8a2dd01fb4baef26.png")
      create(:inspiration)
      create(:photo)
    end

    context "when user is not signed in" do
      before { visit root_path }

      let(:navigation) { page.find('header > ul') }

      it "contains exactly two navigation links" do
        navigation.should have_selector('a', :count => 2)
      end

      it "contains a sign up link" do
        navigation.should have_link_to(new_user_session_path)
      end

      it "contains a sign in link" do
        navigation.should have_link_to(new_user_registration_path)
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      # See spec/support/feature_spec_helper.rb
      before { login_as(user) }

      it "contains a photo upload form" do
        page.should have_selector("form[action='#{photos_path}'][method='post'][enctype='multipart/form-data']")
      end
    end
  end
end
