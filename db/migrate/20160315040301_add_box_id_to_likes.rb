class AddBoxIdToLikes < ActiveRecord::Migration
  def change
  	add_column :likes, :box_id, :integer
  end
end
