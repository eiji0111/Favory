class Room < ApplicationRecord
  
  has_many :chats
  has_many :customer_rooms
  has_many :notifications, dependent: :destroy
  
  # 通知を作成（メッセージ）
  def create_notification_chat!(current_customer, chat_id, another_customer_room)
    temp_ids = Chat.select(:customer_id).where(room_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_chat!(current_customer, chat_id, temp_id["customer_id"])
    end
    save_notification_chat!(current_customer, chat_id, another_customer_room.customer_id) if temp_ids.blank?
  end
  
  def save_notification_chat!(current_customer, chat_id, visited_id)
    notification = current_customer.active_notifications.new(
      room_id: id,
      chat_id: chat_id,
      visited_id: visited_id,
      action: "chat"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
