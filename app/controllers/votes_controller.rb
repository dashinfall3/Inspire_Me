class VotesController < ApplicationController

	def new
		@vote = Vote.new
	end

	def create
		@vote = current_user.votes.build params[:vote]
		photo = Photo.find(params[:vote][:photo_id])
		if @vote.save
			User.update_counters photo.user, :votes_count => +1
			redirect_to :back
		else
			redirect_to :back
		end
	end
end