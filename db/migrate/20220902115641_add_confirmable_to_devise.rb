class AddConfirmableToDevise < ActiveRecord::Migration[7.0]
  def up
    add_column :traders, :confirmation_token, :string
    add_column :traders, :confirmed_at, :datetime
    add_column :traders, :confirmation_sent_at, :datetime
    add_column :traders, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :traders, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    Trader.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_index :traders, :confirmation_token
    remove_columns :traders, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :traders, :unconfirmed_email # Only if using reconfirmable
  end
end
