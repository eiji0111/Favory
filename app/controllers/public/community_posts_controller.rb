class Public::CommunityPostsController < ApplicationController
  
  def create
    @community_post = current_customer.community_posts.new(community_posts_params)
    respond_to do |format|
      if @community_post.save
        @community_posts = CommunityPost.recent(@community_post.community).page(params[:page]).per(10)
        format.js
      else
        format.js { render :errors }
      end
    end
  end

  private
  
  def community_posts_params
    params.require(:community_post).permit(:content, :customer_id, :community_id)
  end
end
