class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  before_action :correct_customer, only: [:edit, :update, :unsubscribe, :withdraw]
  
  def men
    @q = Customer.valid_men(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).includes(:follower_customer).page(params[:page]).per(36)
  end
  
  def women
    @q = Customer.valid_women(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).includes(:follower_customer).page(params[:page]).per(36)
  end
  
  def show
    @communities = Community.where(owner_id: @customer.id).order(updated_at: :desc)
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      if @customer.saved_changes?
        redirect_to customer_path(@customer)
      else
        redirect_to customer_path(@customer), alert: 'プロフィールを更新できませんでした'
      end
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer.update(is_valid: false)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def correct_customer
    redirect_to customer_path(current_customer), alert: '権限がありません' if @customer != current_customer
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(
      :name, :nickname, :profile_image, :one_thing, :introduction, :birthday, :address, :birthplace,
      :work_location, :jobs, :annual_income, :height, :body_shape, :blood_type, :personality,
      :holiday, :car, :hobby, :cigarettes, :alcohol, :housemate, :marriage_history, :children,
      :willingness_to_marry, :want_kids, :hope_encounter, :date_cost
    )
  end
end
