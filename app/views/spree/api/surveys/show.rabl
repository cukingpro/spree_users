object @survey

attributes :id, :user_id, :family, :habit
child(:liked_ingredients => :liked_ingredients){ extends "spree/api/ingredients/show" }
child(:hated_ingredients => :hated_ingredients){ extends "spree/api/ingredients/show" }