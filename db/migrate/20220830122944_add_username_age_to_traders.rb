class AddUsernameAgeToTraders < ActiveRecord::Migration[7.0]
  def change
    add_column :traders, :username, :string
    add_column :traders, :age, :integer
  end
end
