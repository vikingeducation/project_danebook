class AddPolymorphismToLikingTable < ActiveRecord::Migration
  def change
    remove_column :likings, :post_id
    add_column :likings, :likeable_type, :string
    add_column :likings, :likeable_id, :integer

    add_index :likings, [:likeable_type, :likeable_id], unique: true
  end
end
