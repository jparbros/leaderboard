class AddMessageToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :message, :string
  end
end
