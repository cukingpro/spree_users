class AddBalanceToUsers < ActiveRecord::Migration
  def change
  	add_column :spree_users, :balance, :decimal, precision: 8, scale: 2
  end
end
