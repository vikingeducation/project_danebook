class MakeLikablePolymorphicPostsComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :likes, :post_id, :likable_id
    add_column :likes, :likable_type, :string
  end
end
