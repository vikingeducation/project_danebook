class RemovePostIdFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :post_id
  end
  add_index :comments, [:commentable_type, :commentable_id]
end
