class ChangeDatatypeChildrenOfCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :children, :integer, default: 0
  end
end
