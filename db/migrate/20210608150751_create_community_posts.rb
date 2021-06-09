class CreateCommunityPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :community_posts do |t|
      t.references :community, foreign_key: true
      t.references :customer, foreign_key: true
      t.text :content, null: false
      t.timestamps
    end
  end
end
