class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :about_me
      t.text :words_to_live_by
      t.text :hometown
      t.text :current_city
      t.text :college
      t.text :telephone

      t.timestamps
    end
  end
end
