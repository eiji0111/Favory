class CommunityCustomer < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :community, optional: true
end
