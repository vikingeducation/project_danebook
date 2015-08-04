class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :college
      t.string :hometown
      t.string :current_town
      t.string :telephone
      t.string :words_to_live_by 
      t.string :about_me
      t.integer :user_id 

      t.timestamps null: false
    end
  end
end
