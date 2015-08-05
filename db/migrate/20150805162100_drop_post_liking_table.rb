class DropPostLikingTable < ActiveRecord::Migration
  def change
    drop_table :post_likings
  end
end
