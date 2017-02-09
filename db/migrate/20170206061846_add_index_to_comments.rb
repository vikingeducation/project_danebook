class AddIndexToComments < ActiveRecord::Migration[5.0]
  def change
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
