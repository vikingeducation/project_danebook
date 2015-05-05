class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false
      t.integer :day , null: false
      t.integer :month, null: false
      t.integer :year, null: false
      t.string :gender, null: false

      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone

      t.text :words_to_live_by
      t.text :about_me

      t.timestamps
    end

    add_index :profiles, :user_id, :unique => true
  end
end
