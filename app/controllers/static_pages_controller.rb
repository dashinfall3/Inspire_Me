class StaticPagesController < ApplicationController
  def index
  	Inspiration.admin_inspirations.live.first ? @inspiration = Inspiration.admin_inspirations.live.first : @inspiration = Inspiration.first
    @user_photos = @inspiration.photo_by_user(current_user).shuffle
    @non_user_photos = @inspiration.photo_by_non_user(current_user).shuffle
    @photos = @user_photos + @non_user_photos
    @photo = Photo.new
    @vote = Vote.new
  end
end
