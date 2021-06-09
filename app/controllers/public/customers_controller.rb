class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def men
    @q = Customer.where(sex: 0, is_valid: true).ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).page(params[:page])
  end
  
  def women
    @q = Customer.where(sex: 1, is_valid: true).ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).page(params[:page])
  end
  
  def show
    @communities = Community.where(owner_nickname: @customer.nickname)
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end
  
  def unsubscribe
    @customer = Customer.find_by(email: params[:email])
  end
  
  def withdraw
    @customer = Customer.find_by(email: params[:email])
    @customer.update(is_valid: false)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:name, :profile_image, :nickname, :birthday, :address,
                                     :hobby, :jobs, :annual_income, :marriage_history,
                                     :children, :personality, :one_thing)
  end
end
