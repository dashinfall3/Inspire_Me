class StaticPagesController < ApplicationController
  def index
  	Inspiration.admin_inspirations.live.first ? @inspiration = Inspiration.admin_inspirations.live.first : @inspiration = Inspiration.first
    @photos = @inspiration.photos
    @photo = Photo.new
    @vote = Vote.new
  end
end
