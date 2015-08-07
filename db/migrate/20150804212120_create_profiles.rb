class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer "user_id", null: false
      t.string "college"
      t.string "telephone"
      t.string "hometown"
      t.string "current_location"
      t.text "about_me"
      t.text "words_to_live_by"

      t.timestamps null: false
    end
  end
end
