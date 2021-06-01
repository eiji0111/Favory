class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      flash[:notice] = 'プロフィールを更新しました'
      redirect_to customer_path(@customer)
    else
      render "edit"
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:profile_image, :nickname, :birthday, :address, :hobby, :jobs,
                                     :annual_income, :marriage_history, :children, :personality, :one_thing)
  end
end
