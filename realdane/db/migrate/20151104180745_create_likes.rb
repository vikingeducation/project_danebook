class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :user_chat_id
      t.string :user_chat_type
      t.timestamps null: false
    end
    
    add_index :likes, [:user_chat_type, :user_chat_id]
  end
end
