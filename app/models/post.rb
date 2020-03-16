class Post < ApplicationRecord
	mount_uploader :image, ImageUploader
	mount_uploader :video, VideoUploader
	acts_as_taggable
	belongs_to :user
	has_many :likes,dependent: :destroy
	has_many :liked_users, through: :likes, source: :user
	has_many :comment, dependent: :destroy
	validates :body, presence: :true, length: { maximum: 200}
	has_many :replies, class_name: Comment.to_s, foreign_key: :reply_comment, dependent: :destroy
end
