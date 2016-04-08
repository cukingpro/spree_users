class AddDefaultBalanceToUsers < ActiveRecord::Migration
  def change
  	change_column :spree_users, :balance, :decimal, precision: 8, scale: 2, default: 0
  end
end
