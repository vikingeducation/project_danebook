class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :life_words
      t.text :about_me
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :profiles, :user_id, :unique => true
  end
end
