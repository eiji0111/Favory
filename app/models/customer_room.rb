class CustomerRoom < ApplicationRecord
  
  belongs_to :customer
  belongs_to :room
  has_many :chats, through: :room
end
