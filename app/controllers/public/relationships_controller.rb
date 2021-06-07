class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  
  def follow
    @customer = Customer.find(params[:id])
    current_customer.follow(params[:id])
  end

  def unfollow
    @customer = Customer.find(params[:id])
    current_customer.unfollow(params[:id])
  end
  
  # お気に入り一覧
  def followed
    @followeds = current_customer.following_customer.page(params[:page])
  end
  
  # お気に入りされた一覧
  def follower
    @followers = current_customer.follower_customer.page(params[:page])
  end
  
  # 互いにお気に入りしている
  def matchers
    @matchers = current_customer.matchers.page(params[:page])
  end
end
