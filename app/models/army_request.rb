class ArmyRequest < ApplicationRecord

  belongs_to :customer
  
  attachment :identification_image
  validates :army_type, presence: true
  validates :base, presence: true
  validates :army_class, presence: true
  validates :occupation, presence: true
  validates :identification_number, presence: true
  
  enum type: { "陸自": 0, "海自": 1, "空自": 2 }
end
