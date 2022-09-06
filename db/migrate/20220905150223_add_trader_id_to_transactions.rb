class AddTraderIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :trader_id, :integer
  end
end
