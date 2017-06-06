class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :gender
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :words
      t.text :about

      t.timestamps
    end

    add_index :profiles, :user_id, unique: true
  end
end
