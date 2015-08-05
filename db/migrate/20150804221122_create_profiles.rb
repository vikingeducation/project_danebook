class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :email
      t.string :college
      t.string :phone
      t.string :hometown
      t.string :homecountry
      t.string :livesintown
      t.string :livesincountry
      t.string :wordsby
      t.string :wordsabout



      t.timestamps null: false
    end
  end
end
