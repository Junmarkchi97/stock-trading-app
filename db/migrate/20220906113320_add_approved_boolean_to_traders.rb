class AddApprovedBooleanToTraders < ActiveRecord::Migration[7.0]
  def change
    add_column :traders, :approved_boolean, :boolean, default: false
  end
end
