class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me

      t.timestamps
    end
  end
end
