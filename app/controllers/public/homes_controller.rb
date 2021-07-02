class Public::HomesController < ApplicationController
  before_action :login_customer, only: [:top, :company_profile, :teams_of_use, :privacy_policy]

  def top
  end
  
  def company_profile
  end
  
  def teams_of_use
  end
  
  def privacy_policy
  end
  
  private
  
  def login_customer
    redirect_to customer_path(current_customer) if customer_signed_in?
  end
end
