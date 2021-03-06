class Commentlike < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :comment
  belongs_to :user
  validates_uniqueness_of :comment_id, scope: :user_id
end
