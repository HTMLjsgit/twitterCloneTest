class CommentretweetsController < ApplicationController
	def create
		@commentretweet = current_user.commentretweets.create(comment_id: params[:comment_id])
		redirect_back(fallback_location: root_path)

	end

	def destroy
		@commentretweet = Commentretweet.find_by(comment_id: params[:comment_id], user_id: current_user.id)
		@commentretweet.destroy
		redirect_back(fallback_location: root_path)
	end
end
