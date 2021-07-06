class Public::BlockRelationshipsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @block_customers = current_customer.block_customer
  end
  
  def block
    @customer = Customer.find(params[:id])
    current_customer.block(params[:id])
  end

  def unblock
    @customer = Customer.find(params[:id])
    current_customer.unblock(params[:id])
  end
end
