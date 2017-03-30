class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :posts, :user_id, :unique => true
  end
end
