class CreateRecipeUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :recipe_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
