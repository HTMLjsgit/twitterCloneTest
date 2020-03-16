class Comment < ApplicationRecord
	belongs_to :post,optional: true
	belongs_to :user
  	has_many :commentlikes_users, through: :commentlikes, source: :user
	mount_uploader :image, ImageUploader
	mount_uploader :video, VideoUploader
end
