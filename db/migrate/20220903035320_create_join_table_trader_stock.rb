class CreateJoinTableTraderStock < ActiveRecord::Migration[7.0]
  def change
    create_join_table :traders, :stocks do |t|
      t.index [:trader_id, :stock_id]
      t.index [:stock_id, :trader_id]
    end
  end
end
