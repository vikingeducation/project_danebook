class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :body
      t.integer :user_id, null: false
      t.integer :posted_id

      t.timestamps null: false
    end
  end
end
