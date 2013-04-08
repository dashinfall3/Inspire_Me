class UsersController < ApplicationController
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    @photo = Photo.new
    @inspirations = @user.inspirations.reverse
  end

  def subscribe
    @user = User.find(params[:id])
  	@user.subscription_status = 0
  	@user.save
  	redirect_to :back
  end

  def unsubscribe
    @user = User.find(params[:id])
    @user.subscription_status = 1
  	@user.save
  	redirect_to :back
  end
end
