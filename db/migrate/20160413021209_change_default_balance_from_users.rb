class ChangeDefaultBalanceFromUsers < ActiveRecord::Migration
  def change
  	change_column :spree_users, :balance, :decimal, precision: 12, scale: 2, default: 0
  end
end
