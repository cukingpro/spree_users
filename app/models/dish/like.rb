module Dish
	class Like < ActiveRecord::Base
		belongs_to :user, :class_name => "Spree::User"
		belongs_to :like_products, :class_name => "Spree::Product" , foreign_key: "product_id"
	end
end