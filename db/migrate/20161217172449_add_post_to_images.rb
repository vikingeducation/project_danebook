class AddPostToImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :post, foreign_key: true
  end
end
