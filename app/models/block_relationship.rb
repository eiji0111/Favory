class BlockRelationship < ApplicationRecord
  belongs_to :block, class_name: "Customer"
  belongs_to :blocked, class_name: "Customer"

  validates :block_id, presence: true
  validates :blocked_id, presence: true
end
