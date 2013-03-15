class StaticPagesController < ApplicationController
  def index
    @inspiration = Inspiration.first
    @photos = @inspiration.photos
  end
end
