class CreateBlockRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :block_relationships do |t|
      t.references :block, foreign_key: {to_table: :customers}
      t.references :blocked, foreign_key: {to_table: :customers}
      t.timestamps
      
      t.index [:block_id, :blocked_id], unique: true
    end
  end
end
