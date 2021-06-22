class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def men
    @q = Customer.where(sex: 0).ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).page(params[:page]).per(10)
  end
  
  def women
    @q = Customer.where(sex: 1).ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).page(params[:page]).per(10)
  end
  
  def show
    @communities = Community.where(owner_id: @customer.id).order(updated_at: :desc)
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      flash[:notice] = '会員情報を更新しました'
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  def destroy
    if @customer.sex == 'man'
      if @customer.destroy
        flash[:alert] = '会員を削除しました'
        redirect_to admin_men_path
      else
        render :edit
      end
    else
      if @customer.destroy
        flash[:alert] = '会員を削除しました'
        redirect_to admin_women_path
      else
        render :edit
      end
    end
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:name, :profile_image, :nickname, :birthday, :sex, :address,
                                     :is_valid, :hobby, :jobs, :annual_income, :marriage_history,
                                     :children, :personality, :one_thing)
  end
end
