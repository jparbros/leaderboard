class AddOrderNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :order_number, :string
  end
end
