class AddOrderNumberToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :order_number, :string
  end
end
