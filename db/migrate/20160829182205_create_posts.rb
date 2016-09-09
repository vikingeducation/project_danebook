class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :author_id

      t.timestamps
    end

    change_column :posts, :body, :text, :null => false
    change_column :posts, :author_id, :integer, :null => false
  end
end
