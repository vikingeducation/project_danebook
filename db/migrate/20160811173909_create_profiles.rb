class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :bday_month
      t.integer :bday_day
      t.integer :bday_year
      t.string :gender
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me
      t.integer :user_id
      t.timestamps
    end
  end
end
