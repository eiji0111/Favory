class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def men
    @q = Customer.where(sex: 0).ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).page(params[:page])
  end
  
  def women
    @q = Customer.where(sex: 1).ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @customers = @q.result(distinct: true).page(params[:page])
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
      redirect_to request.referer, alert: '会員情報を更新できませんでした'
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
    params.require(:customer).permit(
      :name, :email,:nickname, :sex, :is_valid, :profile_image, :one_thing, :introduction,
      :birthday, :address, :birthplace, :work_location, :jobs, :annual_income, :height,
      :body_shape, :blood_type, :personality, :holiday, :car, :hobby, :cigarettes, :alcohol,
      :housemate, :marriage_history, :children, :willingness_to_marry, :want_kids, :hope_encounter, :date_cost
    )
  end
end
