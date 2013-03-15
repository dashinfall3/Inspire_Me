class StaticPagesController < ApplicationController
  def index
    @inspiration = Inspiration.first
    @photos = @inspiration.photos
    @photo = Photo.new
  end
end
