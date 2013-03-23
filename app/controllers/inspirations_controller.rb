class InspirationsController < ApplicationController

  def new
    @inspiration = Inspiration.new
  end

  def create
    @inspiration = current_user.inspirations_created.build(params[:inspiration])
    if current_user.admin?
      @inspiration.status = 0
    else
      @inspiration.status = 1
    end
    if @inspiration.save
      #deliver email to friends if @inspiration.status == 1
      redirect_to inspiration_path(@inspiration)
    else
      render :new
    end
  end

  def show
    @inspiration = Inspiration.find(params[:id])
    @photo = Photo.new
  end

end
