class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  mount_uploader :backgroundimage, BackgroundimageUploader
  has_many :posts, dependent: :destroy
  validates :name, presence: true
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  has_many :commentlikes, dependent: :destroy
  has_many :commentlikes_comments, through: :commentlikes, source: :comment
  has_many :retweets, dependent: :destroy
  has_many :relationships, dependent: :destroy,foreign_key: 'user_id'
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  def update_without_current_password(params, *options)
	  params.delete(:current_password)

	  if params[:password].blank? && params[:password_confirmation].blank?
	  	params.delete(:password)
	  	params.delete(:password_confirmation)
	  end

	  result = update_attributes(params, *options)
	  clean_up_passwords
	  result
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def already_likedComment?(comment)
    self.commentlikes.exists?(comment_id: comment.id)
  end

  def already_likedRetweet?(post)
      self.retweets.exists?(post_id: post.id)
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
