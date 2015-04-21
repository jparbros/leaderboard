class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :transacion_number
      t.string :card_number
      t.integer :organization_id
      t.boolean :active, default: false
      t.string :subscription_kind

      t.timestamps
    end
  end
end
