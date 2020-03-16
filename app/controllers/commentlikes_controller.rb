class CommentlikesController < ApplicationController
	def create
		@like = current_user.commentlikes.create!(comment_id: params[:comment_id])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@like = Commentlike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
		@like.destroy
		redirect_back(fallback_location: root_path)
	end
end
