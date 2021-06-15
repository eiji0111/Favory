class Public::CommunitiesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @community = Community.new
    @communities = Community.valid_all(params[:page])
  end
  
  def create
    @community = Community.new(community_params)
    @community.owner_nickname = current_customer.nickname
    if @community.save
      redirect_to communities_path, notice: '管理者が内容を確認・承認したのち、こちらに反映されます'
    else
      redirect_to communities_path, alert: '正しく保存されませんでした'
    end
  end

  def show
    @community = Community.find(params[:id])
    @community_post = CommunityPost.new
    @community_posts = CommunityPost.recent(@community).page(params[:page]).per(10)
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
    unless @community.owner_nickname == current_customer.nickname
      redirect_to communities_path
    end
  end
end
