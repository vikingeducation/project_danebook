class Addbody < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :body, :text
    change_column :comments, :body, :text, :null => false
  end
end
