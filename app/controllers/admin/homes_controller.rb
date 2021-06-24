class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @men_customers = Customer.where(sex: 'man')
    @women_customers = Customer.where(sex: 'woman')
    @communities = Community.all
    @army_requests = ArmyRequest.all
    
    @men_customers_count = @men_customers.group_by_day(:created_at).size
    @women_customers_count = @women_customers.group_by_day(:created_at).size
  end
end
