class FixPostBodyToField < ActiveRecord::Migration
  def change
    remove_column :posts, :body

    add_column :posts, :body, :text
  end
end
