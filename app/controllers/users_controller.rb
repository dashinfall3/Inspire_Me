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
  	current_user.subscription_status = 0
  	current_user.save
  	redirect_to :back
  end

  def unsubscribe
  	current_user.subscription_status = 1
  	current_user.save
  	redirect_to :back
  end
end
