class RenameUserIdForeignKey < ActiveRecord::Migration
  def change
    rename_column :posts, :user_id, :author_id
    rename_column :likes, :user_id, :liker_id
  end
end
