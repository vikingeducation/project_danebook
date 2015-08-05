class CreatePostLikings < ActiveRecord::Migration
  def change
    create_table :post_likings do |t|

      t.integer :like_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
