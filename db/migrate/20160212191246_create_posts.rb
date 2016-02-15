class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.timestamps null: false
      add_foreign_key :posts, :users
    end
  end
end
