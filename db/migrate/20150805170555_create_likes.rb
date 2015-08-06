class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :duty_id
      t.string  :duty_type
      t.integer :liker_id

      t.timestamps null: false
    end
    add_index :likes, [:duty_id, :duty_type] 
  end
end

