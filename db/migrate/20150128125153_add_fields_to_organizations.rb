class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :subscribed, :boolean, default: false
  end
end
