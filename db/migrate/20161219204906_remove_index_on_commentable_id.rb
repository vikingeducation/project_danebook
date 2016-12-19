class RemoveIndexOnCommentableId < ActiveRecord::Migration[5.0]
  def change
  end
  remove_index :comments, :commentable_thing_id
end
