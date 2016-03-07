class AddEmailChangeTokenToSpreeUsers < ActiveRecord::Migration
  def change
  	add_column :spree_users, :email_change_token, :string
  end
end
