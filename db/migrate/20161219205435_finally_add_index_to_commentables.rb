class FinallyAddIndexToCommentables < ActiveRecord::Migration[5.0]
  def change
  end
  add_index :comments, [:commentable_type, :commentable_id]
end
