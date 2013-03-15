class InspirationsController < ApplicationController

  def new
    @inspiration = Inspiration.new
  end

  def create
    @inspiration = Inspiration.new(params[:inspiration])
    if @inspiration.save
      redirect_to inspiration_path(@inspiration)
    else
      render :new
    end
  end

  def show
    @inspiration = Inspiration.find(params[:id])
  end

end
