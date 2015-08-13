class FixPostsColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :post, :body
  end
end
