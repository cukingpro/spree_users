class ChangeColumnNameToSpreeUsers < ActiveRecord::Migration
  def change
  	 rename_column :spree_users, :email_change, :change_email

  end
end
