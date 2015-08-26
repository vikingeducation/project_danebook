class CreateCommentableCols < ActiveRecord::Migration
  def change
    rename_column :comments, :post_id, :commentable_id
    add_column :comments, :commentable_type, :string
  end
end
