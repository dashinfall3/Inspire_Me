class StaticPagesController < ApplicationController
  def index
  	Inspiration.live.first ? @inspiration = Inspiration.live.first : @inspiration = Inspiration.first
    @photos = @inspiration.photos
    @photo = Photo.new
  end
end
