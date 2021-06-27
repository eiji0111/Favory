class Admin::CommunitiesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  
  def index
    @communities = Community.order(created_at: :DESC).page(params[:page])
  end

  def show
    @customer = Customer.find_by(id: @community.owner_id)
  end

  def edit
  end
  
  def update
    if @community.update(community_params)
      redirect_to admin_community_path(@community), notice: 'コミュニティ情報を変更しました'
    else
      render :edit
    end
  end
  
  def destroy
    if @community.destroy
      redirect_to admin_communities_path, notice: 'コミュニティを削除しました'
    else
      render :edit
    end
  end
  
  private
  
  def set_community
    @community = Community.find(params[:id])
  end
  
  def community_params
    params.require(:community).permit(:name, :introduction, :community_image, :owner_id, :valid_status)
  end
end
