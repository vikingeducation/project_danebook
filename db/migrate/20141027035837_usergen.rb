class Usergen < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.string :gender
      t.integer :month
      t.integer :year
      t.integer :day
      t.text :words_to_live_by
      t.text :about_me
      t.string :phone
      t.string :college
      t.string :hometown
      t.string :town
      t.timestamps
    end
  end
end
