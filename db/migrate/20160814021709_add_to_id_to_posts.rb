class AddToIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :from, :integer
  end
end
