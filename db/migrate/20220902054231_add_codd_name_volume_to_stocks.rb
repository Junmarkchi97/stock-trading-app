class AddCoddNameVolumeToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :name, :string
    add_column :stocks, :volume, :integer
  end
end
