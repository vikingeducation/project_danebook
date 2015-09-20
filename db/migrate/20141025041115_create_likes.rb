class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :likable, polymorphic: true, null: false
      t.integer    :user_id, null: false

      t.timestamps
    end

    add_index :likes, [:likable_type, :likable_id, :user_id], unique: true
    add_column :posts, :likes_count, :integer, default: 0, null: false
  end
end
