class MakeLikesPolymorphic < ActiveRecord::Migration[5.0]
  def change
    remove_column :likes, :post_id, :integer
    add_reference :likes, :likeable, polymorphic: true, index: false
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
  end
end
