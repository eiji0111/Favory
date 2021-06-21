class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.string :community_image_id
      t.integer :owner_id, null: false
      t.integer :valid_status, null: false, default: 0
      t.timestamps
    end
  end
end
