class AddDepartamentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :departament_id, :integer
  end
end
