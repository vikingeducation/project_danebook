class DropLikeTable < ActiveRecord::Migration
  def change
    drop_table :likes
  end
end
