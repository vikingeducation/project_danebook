class AddCommentableTypeId < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
