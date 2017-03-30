class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :about_me
      t.text :words_to_live_by
      t.string :hometown
      t.string :current_city
      t.string :college
      t.string :telephone
      t.integer :day
      t.integer :month
      t.integer :year
      t.string :gender

      t.timestamps
    end
    add_index :profiles, :user_id, :unique => true
  end
end
