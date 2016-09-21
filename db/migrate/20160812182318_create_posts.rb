class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :post_author_id
      t.integer :post_receiver_id
      t.integer :postable_id
      t.string :postable_type
      t.timestamps
    end

    add_index :posts, [:postable_id, :postable_type]
  end
end
