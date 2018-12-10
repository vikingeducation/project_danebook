class RemovePostIdFromCommentsAndAddCommentable < ActiveRecord::Migration[5.0]
  def change

    remove_column :comments, :post_id
    add_reference :comments, :commentable, polymorphic: true

  end
end
