class AddColumnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_id, :integer
  end
  add_index :comments, [:commentable_type, :commentable_id]
end
