class MakeLikesPolymorphic < ActiveRecord::Migration
  def change
    remove_index :likes, [:post_id, :user_id]
    remove_column :likes, :post_id
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string

    add_index :likes, [:likeable_id, :likeable_type, :user_id], unique: true, name: :like_index
  end
end
