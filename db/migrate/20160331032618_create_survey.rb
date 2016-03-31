class CreateSurvey < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :user_id
      t.integer :family
      t.integer :liked_ingredient_ids, array: true, default: []
      t.integer :hated_ingredient_ids, array: true, default: []
      t.string :habit

      t.timestamps null: false
    end
  end
end
