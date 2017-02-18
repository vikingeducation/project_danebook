class CreateLikesAgain < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :liker_id
      t.string :likable_thing_type
      t.integer :likable_thing_id

      t.timestamps
    end

    add_index :likes, [:likable_thing_type, :likable_thing_id]
  end
end
