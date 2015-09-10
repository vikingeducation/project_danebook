class RemoveIndexFromComments < ActiveRecord::Migration
  def change
    remove_index :comments, name: "index_comments_on_commentable_type_and_commentable_id"
  end
end
