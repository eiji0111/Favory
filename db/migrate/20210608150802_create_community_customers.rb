class CreateCommunityCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :community_customers do |t|
      t.references :community, foreign_key: true
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
