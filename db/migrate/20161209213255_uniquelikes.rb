class Uniquelikes < ActiveRecord::Migration[5.0]
  add_index :likes, [:likeable_id, :likeable_type, :user_id], unique: true 
end
