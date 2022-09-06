class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :price
      t.integer :volume

      t.timestamps
    end
  end
end
