class CreateLikings < ActiveRecord::Migration
  def change
    create_table :likings do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
    add_index :likings, [:user_id, :post_id], unique: true
  end
end
