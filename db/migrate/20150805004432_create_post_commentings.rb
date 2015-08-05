class CreatePostCommentings < ActiveRecord::Migration
  def change
    create_table :post_commentings do |t|

      t.integer :post_id
      t.integer :comment_id

      t.timestamps null: false
    end
  end
end
