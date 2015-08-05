class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :college_name
      t.string :hometown
      t.string :current_home
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me

      t.timestamps null: false
    end
  end
end
