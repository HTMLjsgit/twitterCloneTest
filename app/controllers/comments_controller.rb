class CommentsController < ApplicationController
	before_action :comment_find, only: [:destroy,:show]
	before_action :is_mine, only: [:destroy]
	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			redirect_back(fallback_location: root_path)
		else
			redirect_back(fallback_location: root_path)
		end
	end
	def destroy
		if @comment.destroy
			redirect_to root_path
		else
			redirect_to root_path
		end
	end

	def show
		@like = Commentlike.new
		@new_comments = Comment.new
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :post_id,:image, :video,:reply_comment)
	end
	def comment_find
		@comment = Comment.find params[:id]
	end
	def is_mine
		if @comment.user_id != current_user.id
			redirect_to root_path
		end
	end
end
