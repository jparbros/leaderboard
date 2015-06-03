class AddCartTypeToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :card_type, :string
  end
end
