class Public::RoomsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    # 共通のルームidを取得
    my_rooms_ids = current_customer.customer_rooms.select(:room_id)
    # チャット相手のcustomer_roomを取得
    @customer_rooms = CustomerRoom.includes(:chats, :customer).where(room_id: my_rooms_ids)
                      .where.not(customer_id: current_customer.id).reverse_order
  end
end
