class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.integer :user_id, null: false
    	t.string :hometown
    	t.string :current_city
    	t.string :telephone
    	t.text :description
    	t.text :life_words

      t.timestamps
    end
    add_index :profiles, :user_id, :unique => true
  end
end
