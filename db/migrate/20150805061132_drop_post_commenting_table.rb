class DropPostCommentingTable < ActiveRecord::Migration
  def change
    drop_table :post_commentings
  end
end
