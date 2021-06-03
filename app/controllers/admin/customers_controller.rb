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
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
