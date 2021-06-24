class CommunityCustomer < ApplicationRecord
  belongs_to :community, optional: true
  belongs_to :customer, optional: true
end
