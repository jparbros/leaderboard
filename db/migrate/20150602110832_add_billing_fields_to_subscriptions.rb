class AddBillingFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :billing_start, :date
    add_column :subscriptions, :billing_day, :integer
  end
end
