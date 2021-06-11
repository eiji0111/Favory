class AddArmyFlagToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :army_flag, :boolean, null: false, default: false
  end
end
