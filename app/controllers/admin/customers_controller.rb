class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def men
    @customers = Customer.where(sex: 0).page(params[:page]).per(10)
  end
  
  def women
    @customers = Customer.where(sex: 1).page(params[:page]).per(10)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      flash[:success] = '会員情報を更新しました'
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:profile_image, :nickname, :birthday, :address, :is_valid, :hobby, :jobs,
                                     :annual_income, :marriage_history, :children, :personality, :one_thing)
  end
end
