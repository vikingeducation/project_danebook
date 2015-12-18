class AddCommentableToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :post_id

    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
    
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
