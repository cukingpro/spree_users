class ChangeColumnNameToSpreeUsers < ActiveRecord::Migration
  def change
<<<<<<< HEAD
  	rename_column :spree_users, :email_change, :change_email
=======
  	 rename_column :spree_users, :email_change, :change_email
>>>>>>> 242ec171b27d93ea1403ac437bb3d14872154120

  end
end
