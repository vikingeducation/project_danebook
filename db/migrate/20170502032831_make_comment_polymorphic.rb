class MakeCommentPolymorphic < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :commentable, polymorphic: true, index: true
    remove_column :comments, :post_id, :integer
  end
end
