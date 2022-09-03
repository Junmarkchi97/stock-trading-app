class AddVolumeToStocksTraders < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks_traders, :volume, :integer, default: 0
  end
end
