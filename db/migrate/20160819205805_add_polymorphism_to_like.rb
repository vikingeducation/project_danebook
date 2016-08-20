class AddPolymorphismToLike < ActiveRecord::Migration[5.0]
  def change

    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string
    remove_column :likes, :post_id

  end
end
