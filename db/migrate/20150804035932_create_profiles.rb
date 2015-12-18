class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :first_name
      t.string :last_name
      t.integer :birthday_month
      t.integer :birthday_day
      t.integer :birthday_year
      t.string :gender
      t.string :hometown
      t.string :current_lives
      t.string :telephone
      t.string :words_to_live_by
      t.string :about_me

      t.timestamps null: false
    end
  end
end
