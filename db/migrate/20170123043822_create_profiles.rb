class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :college
      t.string :hometown
      t.string :current_location
      t.string :telephone
      t.text :words
      t.text :about_me

      t.timestamps
    end
  end
end
