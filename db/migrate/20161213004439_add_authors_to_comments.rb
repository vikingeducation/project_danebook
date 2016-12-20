class AddAuthorsToComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :post_id, :user_id
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
  end
end
