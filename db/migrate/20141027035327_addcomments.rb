class Addcomments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :comment_body
      t.integer :commentable_id
      t.integer :commentable_type
      t.timestamps
    end
  end
end
