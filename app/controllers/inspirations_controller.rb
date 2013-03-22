class InspirationsController < ApplicationController

  def new
    @inspiration = Inspiration.new
  end

  def create
    @inspiration = Inspiration.new(params[:inspiration])
    if @inspiration.creator.find_by_email('inspireme444@gmail.com')
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
  end

end
