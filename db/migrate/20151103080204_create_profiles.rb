class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me
      t.integer :user_id

      t.index :college
      t.index :hometown
      t.index :currently_lives
      t.index :telephone
      t.index :user_id

      t.timestamps null: false
    end
  end
end
