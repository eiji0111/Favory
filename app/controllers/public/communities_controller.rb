class Public::CommunitiesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
    @community = Community.new
  end

  def index
    @communities = Community.all.order(updated_at: :desc)
  end
  
  def create
    @community = Community.new(community_params)
    @community.owner_nickname = current_customer.nickname
    if @community.save
      redirect_to communities_path, notice: 'コミュニティを作成しました'
    else
      render :new
    end
  end

  def show
    @community = Community.find(params[:id])

    # if !@community.customers.include?(current_customer)
    #   @community.customers << current_customer
    # end

    @community_posts = CommunityPost.where(community_id: @community.id).all
  end

  def edit
  end
  
  def update
    if @community.update(community_params)
      redirect_to communities_path, notice: 'コミュニティを更新しました'
    else
      render "edit"
    end
  end
  
  private
  def community_params
    params.require(:community).permit(:name, :introduction, :community_image)
  end
  
  def ensure_correct_user
    @community = Community.find(params[:id])
    unless @community.owner_id == current_customer.id
      redirect_to communities_path
    end
  end
end
