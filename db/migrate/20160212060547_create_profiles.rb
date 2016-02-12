class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.date :birthday
      t.string :hometown
      t.string :current_location
      t.string :school
      t.string :motto
      t.text :about
      t.string :telephone
      t.timestamps null: false
    end
  end
end
