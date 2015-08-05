class CreateUserPostings < ActiveRecord::Migration
  def change
    create_table :user_postings do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
    add_index :user_postings, :user_id, :unique=> true
    add_index :user_postings, :post_id, :unique=> true
  end
end
