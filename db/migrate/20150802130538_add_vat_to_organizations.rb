class AddVatToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :vat, :string
  end
end
