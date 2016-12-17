class AddIndexToPostIdinComments < ActiveRecord::Migration[5.0]
  def change
  end
  add_index :comments, :post_id
end
