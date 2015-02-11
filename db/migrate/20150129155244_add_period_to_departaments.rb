class AddPeriodToDepartaments < ActiveRecord::Migration
  def change
    add_column :departaments, :period, :string
  end
end
