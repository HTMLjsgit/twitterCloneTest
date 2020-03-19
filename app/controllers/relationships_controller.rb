class RelationshipsController < ApplicationController
	before_action :set_user

	def create
		user = User.find(params[:relationship][:follow_id])
		following = current_user.follow(user)
		if following.save
			flash[:success] = "ユーザーをフォローしました"
			redirect_to user_path(user)
		else
			flash.now[:alert] = "ユーザーのフォローに失敗しました"
			redirect_to user_path(user)
		end
	end

	def destroy
		user = User.find(params[:relationship][:follow_id])
		following = current_user.unfollow(user)
		if following.destroy
			flash[:success] = "ユーザーのフォローを削除しました"
			redirect_to user_path(user)
		else
			flash.now[:alert] = "ユーザーのフォロー削除に失敗しました"
			redirect_to user_path(user)
		end
	end

	private

	def set_user
		 user = User.find params[:relationship][:follow_id]
	end
end
