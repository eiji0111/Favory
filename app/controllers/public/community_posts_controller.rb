class Public::CommunityPostsController < ApplicationController
  
  def create
    @community_posts = current_customer.community_posts.new(community_posts_params)
    if @community_posts.save
      @community_posts = CommunityPost.recent(@community_posts.community).page(params[:page]).per(10)
    else
      redirect_back fallback_location: @community_posts
    end
  end

  private
  
  def community_posts_params
    params.require(:community_post).permit(:content, :customer_id, :community_id)
  end
end
