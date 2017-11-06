class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.datetime :birthday
      t.string :gender
      t.string :telephone
      t.string :college
      t.string :hometown
      t.string :currenty_lives
      t.text :words_to_live_by
      t.text :about_me
      t.timestamps
    end
  end
end
