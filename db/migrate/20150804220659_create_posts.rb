class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, foreign_key: true
      t.string :body

      t.timestamps null: false
    end
  end
end
