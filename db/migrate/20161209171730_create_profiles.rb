class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|

      t.integer  :birth_month,     null: false
      t.integer  :birth_day,       null: false
      t.integer  :birth_year,      null: false
      t.string   :gender,          null: false
      t.string   :college
      t.string   :hometown
      t.string   :current_town
      t.string   :phone
      t.text     :words_to_live_by
      t.text     :about_me 
      t.references :user     

      t.timestamps
    end
  end
end
