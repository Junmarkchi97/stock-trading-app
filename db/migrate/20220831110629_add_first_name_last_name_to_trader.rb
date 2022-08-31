class AddFirstNameLastNameToTrader < ActiveRecord::Migration[7.0]
  def change
    add_column :traders, :first_name, :string
    add_column :traders, :last_name, :string
    remove_column :traders, :username
  end
end
