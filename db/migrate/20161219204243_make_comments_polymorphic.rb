class MakeCommentsPolymorphic < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :post_id, :commentable_thing_id
    add_column :comments, :commentable_thing_type, :string
  end
end
