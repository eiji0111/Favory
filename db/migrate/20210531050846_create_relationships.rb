class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :followed, foreign_key: {to_table: :customers}
      t.references :follower, foreign_key: {to_table: :customers}
      t.timestamps
      
      t.index [:followed_id, :follower_id], unique: true
    end
  end
end
