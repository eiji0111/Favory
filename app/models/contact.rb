class Contact < ApplicationRecord
  
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }
  validates :content, presence: true, length: { maximum: 255,minimum: 20 }
end
