class CommunityPost < ApplicationRecord
  belongs_to :community
  belongs_to :customer
  
  validates :content, presence: true
end
