class AddSettingsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :rolling, :boolean, default: false
    add_column :organizations, :rolling_time, :integer
  end
end
