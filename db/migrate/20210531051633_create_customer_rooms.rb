class CreateCustomerRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_rooms do |t|
      t.integer :customer_id, null: false
      t.integer :room_id, null: false
      t.timestamps
    end
  end
end