class CreateLikings < ActiveRecord::Migration[5.0]
  def change
    create_table :likings do |t|
      t.integer :user_id
      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps
    end
  end
end
