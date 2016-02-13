class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body, null: false
      t.integer :user_id, null: false

      t.index :user_id

      t.timestamps null: false
    end
  end
end
