class ChangeCustomersColumnsLimit < ActiveRecord::Migration[5.2]
  def up
    change_column :customers, :name, :string, limit: 20
    change_column :customers, :nickname, :string, limit: 20
  end
  def down
    change_column :customers, :name, :string
    change_column :customers, :nickname, :string
  end
end
