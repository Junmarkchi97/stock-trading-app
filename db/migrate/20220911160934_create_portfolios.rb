class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.integer :trader_id
      t.integer :stock_id
      t.integer :volume

      t.timestamps
    end
  end
end
