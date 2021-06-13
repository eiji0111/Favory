class CommunityPost < ApplicationRecord
  belongs_to :community
  belongs_to :customer
  
  scope :recent, -> (community) { where(community_id: community.id).includes(:customer).order(created_at: :desc) }
  
  validates :content, presence: true
end
