class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  
  def follow
    @customer = Customer.find(params[:id])
    current_customer.follow(params[:id])
    @customer.create_notification_follow!(current_customer)
  end

  def unfollow
    @customer = Customer.find(params[:id])
    current_customer.unfollow(params[:id])
  end
  
  def followed
    @followeds = current_customer.following_customer.page(params[:page]) # お気に入り一覧
    @followers = current_customer.follower_customer.page(params[:page]) # お気に入りされた一覧
    @matchers = current_customer.matchers.page(params[:page]) # マッチング成立
  end
  
  # お気に入りされた一覧
  def follower
  end
  
  # 互いにお気に入りしている
  def matchers
  end
end
