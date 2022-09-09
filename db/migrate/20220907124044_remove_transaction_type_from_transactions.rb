class RemoveTransactionTypeFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :transaction_type, :integer
    add_column :transactions, :transaction_type, :boolean
  end
end
