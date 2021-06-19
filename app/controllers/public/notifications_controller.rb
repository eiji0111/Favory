class Public::NotificationsController < ApplicationController
  
  def index
    notifications_all = current_customer.passive_notifications
    notifications_all.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = notifications_all.includes(:visitor, :visited).where.not(visitor_id: current_customer.id).page(params[:page]).per(36)
  end
end
