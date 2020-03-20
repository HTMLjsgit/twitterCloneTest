class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update]
	before_action :is_mine, only: [:update, :edit]
  def show
  	@user = User.find params[:id]
    @posts = @user.posts
    @likes = @user.likes
    @comments = @user.comments
    @retweets = @user.retweets
    @postsAll = Post.all
    @retweetsAll = Retweet.all
    @usersAll = User.all
    @users = @user.relationships
  end

  def follow
    @user = User.find params[:id]
    @users = @user.relationships
    @usersAll = User.all
  end

  def edit
  	@user = User.find params[:id]
  end

  def update
  	@user = User.find params[:id]
  	@user.update(create_params)
  	redirect_to user_path(@user)
  end

  private
  def create_params
  	params.require(:user).permit(:profile, :name, :image, :backgroundimage)
  end

  def is_mine
  	@user = User.find params[:id]
  	unless @user.id == current_user.id
  		redirect_to user_path(@user)
  	end
  end

end
