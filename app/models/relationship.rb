class Relationship < ApplicationRecord
  belongs_to :followed, class_name: "Customer"
  belongs_to :follower, class_name: "Customer"

  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
