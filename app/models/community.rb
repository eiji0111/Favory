class Community < ApplicationRecord

  has_many :community_customers
  has_many :community_posts
  has_many :customers, through: :community_customers
  
  scope :valid_all, -> (params) { where(valid_status: 1).page(params).order(updated_at: :desc) }
  
  validates :name, presence: true
  validates :introduction, presence: true
  attachment :community_image, destroy: false
  
  enum valid_status: { "申請待ち": 0, "許可済み": 1, "却下": 2 }
end
