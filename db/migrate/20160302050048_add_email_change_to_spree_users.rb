class AddEmailChangeToSpreeUsers < ActiveRecord::Migration
  def change
  	add_column :spree_users, :email_change, :string
  end
end
