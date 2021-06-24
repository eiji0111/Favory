class ArmyRequest < ApplicationRecord

  belongs_to :customer
  
  attachment :identification_image
  validates :army_type, presence: true
  validates :base, length: { maximum: 20, minimum: 2 }, presence: true
  validates :army_class, presence: true
  validates :occupation, length: { maximum: 20, minimum: 2 }, presence: true
  validates :identification_number, length: { maximum: 20, minimum: 8 }, presence: true
  validates :identification_image, presence: true
  
  enum army_type: { "陸自": 0, "海自": 1, "空自": 2 }
  enum army_class: {
    "2士": 0, "1士": 1, "士長": 2, "3曹": 3, "2曹": 4, "1曹": 5, "曹長": 6, "准尉": 7, "3尉": 8,
    "2尉": 9, "1尉": 10, "3佐": 11, "2佐": 12, "1佐": 13, "将補": 14, "将": 15, "幕僚長": 16
  }
end
