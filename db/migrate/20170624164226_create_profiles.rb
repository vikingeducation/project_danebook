class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.integer :birth_day
      t.integer :birth_month
      t.integer :birth_year
      t.string :gender
      t.string :college
      t.string :hometown
      t.string :current_town
      t.string :telephone
      t.text :words_to_live
      t.text :about_me

      t.timestamps
    end
    add_index :profiles, :user_id, :unique => true
  end
end
