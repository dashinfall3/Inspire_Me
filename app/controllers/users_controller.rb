class UsersController < ApplicationController
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    @photo = Photo.new
    @inspirations = @user.inspirations.reverse
  end
end
