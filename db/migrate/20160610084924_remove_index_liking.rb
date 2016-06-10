class RemoveIndexLiking < ActiveRecord::Migration
  def change
    remove_index :likings, [:user_id, :post_id]
  end
end
