class Community < ApplicationRecord

  has_many :community_customers
  has_many :community_posts
  has_many :customers, through: :community_customers
  
  validates :name, presence: true
  validates :introduction, presence: true
  attachment :community_image, destroy: false
end
