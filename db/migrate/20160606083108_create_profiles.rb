class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name,     null: false
      t.string :last_name,      null: false
      t.string :birth_month,    null: false
      t.string :birth_day,      null: false
      t.string :birth_year,     null: false
      t.string :gender,         null: false
      t.string :college
      t.string :hometown
      t.string :current_address
      t.string :phone
      t.string :my_words
      t.string :about_me
      t.integer :user_id,       null: false

      t.timestamps null: false
    end
    add_index :profiles, :user_id, unique: true
  end
end
