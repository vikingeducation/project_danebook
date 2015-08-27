class RenameAuthorAndOwnerColumnsToPoster < ActiveRecord::Migration
  def change
    rename_column :posts, :author_id, :poster_id
    rename_column :photos, :owner_id, :poster_id
  end
end
