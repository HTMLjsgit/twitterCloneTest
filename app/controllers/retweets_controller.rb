class RetweetsController < ApplicationController
	def create
		@retweet = current_user.retweets.create!(post_id: params[:post_id], retweet_comment: params[:retweet_comment])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@retweet = Retweet.find_by(post_id: params[:post_id], user_id: current_user.id)
		@retweet.destroy!
		redirect_back(fallback_location: root_path)
	end
end
