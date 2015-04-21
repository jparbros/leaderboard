class AddBoardNameToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :boardname, :string
  end
end
