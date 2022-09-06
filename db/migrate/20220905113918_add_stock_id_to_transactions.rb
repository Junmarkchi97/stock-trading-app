class AddStockIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :stock_id, :integer
  end
end
