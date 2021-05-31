class ChangeColumnsAddNotnullOnCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :customers, :birthday, false
  end
end
