class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  
  def follow
    current_customer.follow(params[:id])
    redirect_back fallback_location: @customer
  end

  def unfollow
    current_customer.unfollow(params[:id])
    redirect_back fallback_location: @customer
  end
  
  # お気に入り一覧
  def followed
    customer = Customer.find(params[:id])
    @followeds = customer.following_customer
  end
end
