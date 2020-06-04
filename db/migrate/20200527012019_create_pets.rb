class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :category
      t.string :pet_name
      t.string :pet_birthday
      t.string :pet_weight
      t.text :pet_description 
      t.integer :user_id
    end
  end
end
