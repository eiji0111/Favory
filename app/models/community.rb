class Community < ApplicationRecord

  has_many :community_customers
  has_many :community_posts
  has_many :customers, through: :community_customers
  
  scope :valid_all, -> { where(valid_status: 1).order(updated_at: :desc).includes(:community_posts) }
  
  validates :name, presence: true
  validates :introduction, presence: true
  attachment :community_image, destroy: false
  
  enum valid_status: { "申請待ち": 0, "許可": 1, "却下": 2 }
end
