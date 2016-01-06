class AddBillingEmailToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :billing_email, :string
  end
end
