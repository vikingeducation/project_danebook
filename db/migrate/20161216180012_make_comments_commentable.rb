class MakeCommentsCommentable < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :post_id
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
  end
end
