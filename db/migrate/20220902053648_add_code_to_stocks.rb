class AddCodeToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :code, :string
    add_index :stocks, :code
  end
end
