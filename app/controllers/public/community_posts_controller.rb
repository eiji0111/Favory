class Public::CommunityPostsController < ApplicationController
  def create
    @community = Community.find_by(id: params[:community_id])
    @community_posts = current_customer.community_posts.new(community_posts_params)
    @community_posts.community_id = params[:community_id]
    if @community_posts.save
      redirect_to community_path(@community.id)
    end
  end

  private
  
  def community_posts_params
    params.require(:community_posts).permit(:content)
  end
end
