class ReworkLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|

      t.string :likeable_type
      t.integer :likeable_id
      t.integer :liker_id

      t.timestamps
    end
  end
end
