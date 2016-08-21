class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me
      t.integer :user_id
      
      t.timestamps
    end
    add_index :profiles, :user_id, unique: true
  end
end
