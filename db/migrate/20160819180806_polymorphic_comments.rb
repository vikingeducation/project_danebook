class PolymorphicComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :post_id
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
