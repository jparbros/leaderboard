class AddCanceledAtToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :canceled_at, :datetime
  end
end
