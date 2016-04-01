module Survey
	class Survey < ActiveRecord::Base
		belongs_to :user, :class_name => "Spree::User"
		
		def liked_ingredients
			Dish::Ingredient.where(id: self.liked_ingredient_ids)
		end

		def hated_ingredients
			Dish::Ingredient.where(id: self.hated_ingredient_ids)
		end 

	end
end