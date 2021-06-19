class Public::ArmyRequestsController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @army_request = ArmyRequest.new
  end
  
  def create
    @army_request = ArmyRequest.new(army_request_params)
    if @army_request.save
      redirect_to customer_path(current_customer), notice: '申請が完了しました。'
    else
      redirect_to request.referer, alert: '申請できませんでした。入力内容をご確認ください。'
    end
  end
  
  private
  
  def army_request_params
    params.require(:army_request).permit(
      :customer_id, :army_type, :base, :army_class, :occupation,
      :identification_number, :identification_image
    )
  end
end
