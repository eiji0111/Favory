class Public::CommunitiesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  
  def index
    @community = Community.new
    @q = Community.valid_all(params[:q])
    @communities = @q.result(distinct: true).order("community_posts.created_at DESC")
  end
  
  def create
    @community = Community.new(community_params)
    @community.owner_id = current_customer.id
    respond_to do |format|
      if @community.save
        @q = Community.valid_all(params[:q])
        @communities = @q.result(distinct: true).order("community_posts.created_at DESC")
        flash.now[:notice] = '管理者が内容を確認・承認したのち、こちらに反映されます'
        format.js
      else
        format.js { render :errors }
      end
    end
  end

  def show
    @community = Community.find(params[:id])
    @community_post = CommunityPost.new
    @community_posts = CommunityPost.recent(@community).page(params[:page]).per(15)
  end

  def edit
  end
  
  def update
    if @community.update(community_params)
      redirect_to community_path(@community)
    else
      render "edit"
    end
  end
  
  private
  def community_params
    params.require(:community).permit(:name, :introduction, :community_image)
  end
  
  def ensure_correct_customer
    @community = Community.find(params[:id])
    unless @community.owner_id == current_customer.id
      redirect_to communities_path
    end
  end
end
