class AddCashToTraders < ActiveRecord::Migration[7.0]
  def change
    add_column :traders, :cash, :decimal, :default => 10000
  end
end
