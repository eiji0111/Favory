class Community < ApplicationRecord

  has_many :customers, through: :community_customers
  has_many :community_customers, dependent: :destroy
  has_many :community_posts, dependent: :destroy
  
  scope :valid_all, -> (params) { where(valid_status: 1).includes(:community_posts).ransack(params) }
  
  attachment :community_image, destroy: false
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :introduction, presence: true, length: { minimum: 10 }
  
  enum valid_status: { "申請待ち": 0, "許可": 1, "却下": 2 }
  
  acts_as_taggable
end
