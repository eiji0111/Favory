class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  
  def followed
  end

  def follow
  end

  def unfollow
  end
end
