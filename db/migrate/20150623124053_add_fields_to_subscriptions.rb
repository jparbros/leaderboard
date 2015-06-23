class AddFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :token, :string
    add_column :subscriptions, :active_until, :date
    remove_column :subscriptions, :transacion_number
    remove_column :subscriptions, :billing_start
    remove_column :subscriptions, :billing_day
    remove_column :subscriptions, :order_number
    remove_column :subscriptions, :active
  end
end
