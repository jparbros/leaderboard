class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transacion_number
      t.integer :amount_cents
      t.string :currency
      t.integer :subscription_id
      t.string :authorization_number
      t.boolean :success, default: false

      t.timestamps
    end
  end
end
