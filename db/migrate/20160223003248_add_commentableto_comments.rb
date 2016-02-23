class AddCommentabletoComments < ActiveRecord::Migration
  def change
    add_column :comments, :commentable_id, :integer, null: false
    add_column :comments, :commentable_type, :string, null: false, inclusion: { in: ["Post", "Photo"]}

    remove_column :comments, :post_id
  end
end
