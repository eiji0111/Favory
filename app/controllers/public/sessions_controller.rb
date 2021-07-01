# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_customer, only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:current_sign_in_at])
  # end
  
  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && !@customer.is_valid
        flash[:alert] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
        redirect_to new_customer_session_path
      end
    end
  end
  
  # ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to customer_path(customer), notice: 'ゲストユーザーとしてログインしました。'
  end
end
