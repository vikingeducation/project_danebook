class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.text :about_me
    	t.text :words_to_live_by
    	t.string :home_city
    	t.string :home_country
    	t.string :current_city
    	t.string :current_country
      t.timestamps null: false
    end
  end
end
