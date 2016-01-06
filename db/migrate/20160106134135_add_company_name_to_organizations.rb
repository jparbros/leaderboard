class AddCompanyNameToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :company_name, :string
  end
end
