object @user

attributes :id, :email, :first_name, :last_name, :balance
child(:images => :images) do
	extends "spree/api/users/images"
end