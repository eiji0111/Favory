class Community < ApplicationRecord

  has_many :community_customers
  has_many :community_posts
  has_many :customers, through: :community_customers
  
  scope :valid_all, -> { where(valid_status: 1).includes(:community_posts).order("community_posts.created_at DESC") }
  
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :introduction, presence: true, length: { minimum: 2 }
  attachment :community_image, destroy: false
  
  enum valid_status: { "申請待ち": 0, "許可": 1, "却下": 2 }
end
