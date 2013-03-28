class PhotosController < ApplicationController
  respond_to :json, :html
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
    @inspiration = @photo.inspiration

    respond_to do |format|
      format.json { render :json => @photo }
      format.html
    end
  end

  def new
    @photo = Photo.new.image
    @photo.success_action_redirect = carrier_redirect_url
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
        format.html { redirect_to :back, notice: 'Photo added to inspiration. Reload in a few seconds to see it.' }
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

  def carrier_redirect
    #perform_async job
    flash[:notice] = "hey I went to the redirect"
    redirect_to root_path
  end
end
