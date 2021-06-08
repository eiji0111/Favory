class RemoveColumnsInCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :provider, :string
    remove_column :customers, :uid, :string
  end
end
