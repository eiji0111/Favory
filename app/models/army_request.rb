class ArmyRequest < ApplicationRecord
  self.inheritance_column = :_type_disabled
  
  belongs_to :customer
  
  attachment :identification_image
  validates :type, presence: true
  validates :base, presence: true
  validates :identification_number, presence: true
  
  enum type: { "陸自": 0, "海自": 1, "空自": 2 }
end
