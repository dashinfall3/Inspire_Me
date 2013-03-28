class PhotosController < ApplicationController
  respond_to :json, :html
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
    @inspiration = @photo.inspiration
  end

  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = current_user.photos.build(params[:photo])
    @inspiration = @photo.inspiration
    respond_to do |format|
      if @photo.save
        current_user.add_as_participant(@photo)
        format.html { redirect_to :back, notice: 'Photo added to inspiration.' }
      else
        format.html { redirect_to :back, notice: "Photo not added. Sorry we're not quite ready for that much inspiration" }
      end
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
    end
  end
end
