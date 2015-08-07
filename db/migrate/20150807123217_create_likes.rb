class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :liker_id, :null => false
      t.integer :liked_id, :null => false

      t.timestamps null: false
    end
  end
end
