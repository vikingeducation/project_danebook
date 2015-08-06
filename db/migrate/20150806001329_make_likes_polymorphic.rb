class MakeLikesPolymorphic < ActiveRecord::Migration
  def change
  	remove_column :likes, :post_id
  	add_column :likes, :commentable_type, :string
  	add_column :likes, :commentable_id, :integer
  end
end
