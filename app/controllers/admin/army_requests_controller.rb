class Admin::ArmyRequestsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = ArmyRequest.includes([:customer]).ransack(params[:q])
    @army_requests = @q.result(distinct: true).order(created_at: :DESC).page(params[:page])
  end

  def show
    @army_request = ArmyRequest.find(params[:id])
    @customer = Customer.find_by(id: @army_request.customer_id)
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_army_requests_path
    else
      render :show
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:army_flag)
  end
end
