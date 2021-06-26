class Public::ChatsController < ApplicationController
  before_action :authenticate_customer!
  
  
  def show
    @customer = Customer.find(params[:id])
    rooms = current_customer.customer_rooms.pluck(:room_id)
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

    if customer_rooms.nil?
      @room = Room.new
      @room.save
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
    else
      @room = customer_rooms.room
    end

    @chats = @room.chats.includes([:customer]).page(params[:page])
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_customer.chats.new(chat_params)
    @chat.save ? (render :create) : (redirect_to request.referer)
    @room = @chat.room
    @customer_room = CustomerRoom.where(room_id: @room.id).where.not(customer_id: current_customer.id)
    @another_customer_room = @customer_room.find_by(room_id: @room.id)
    @room.create_notification_chat!(current_customer, @chat.id, @another_customer_room)
  end
  
  def destroy
    @chat = current_customer.chats.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
