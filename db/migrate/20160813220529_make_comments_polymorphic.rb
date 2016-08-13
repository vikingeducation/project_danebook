class MakeCommentsPolymorphic < ActiveRecord::Migration[5.0]
  def change
    remove_column :likes, :post_id
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
