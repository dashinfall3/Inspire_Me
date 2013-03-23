class StaticPagesController < ApplicationController
  def index
    @inspiration = Inspiration.live.first
    @photos = @inspiration.photos
    @photo = Photo.new
  end
end
