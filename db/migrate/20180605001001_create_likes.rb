class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :post_id, null: false, foreign_key: true
      t.integer :user_id, null: false, foreign_key: true 

      t.timestamps
    end
    add_index :likes, :post_id
    add_index :likes, :user_id
    add_index :likes, [:post_id, :user_id], unique: true
  end
end
