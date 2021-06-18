class CreateArmyRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :army_requests do |t|
      t.references :customer, foreign_key: true
      t.integer :army_type, null: false
      t.string :base, null: false
      t.integer :army_class, null: false
      t.string :occupation, null: false
      
      t.string :identification_number, null:false
      t.string :identification_image_id, null:false
      t.timestamps
    end
  end
end
