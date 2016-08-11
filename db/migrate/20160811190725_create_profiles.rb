class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me

      t.timestamps null: false
    end
  end
end
