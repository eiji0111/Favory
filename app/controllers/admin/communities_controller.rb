class Admin::CommunitiesController < ApplicationController
  
  
  def index
    @communities = Community.page(params[:page])
  end

  def show
    @community = Community.find(params[:id])
  end

  def edit
    @community = Community.find(params[:id])
  end
  
  def update
    @community = Community.find(params[:id])
    if @community.update(community_params)
      redirect_to admin_community_path(@community), notice: 'コミュニティ情報を変更しました'
    else
      render :edit
    end
  end
  
  def destroy
    @community = Community.find(params[:id])
    if @community.destroy
      redirect_to admin_communities_path, notice: 'コミュニティを削除しました'
    else
      render :edit
    end
  end
  
  private
  
  def community_params
    params.require(:community).permit(:name, :introduction, :community_image, :owner_id, :valid_status)
  end
end
