class Public::HomesController < ApplicationController
  before_action :login_customer, only: [:top]

  def top
  end
  
  private
  
  def login_customer
    redirect_to customer_path(current_customer) if customer_signed_in?
  end
end
