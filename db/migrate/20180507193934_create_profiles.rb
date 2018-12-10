class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true, null: false
      t.string :first_name, null: false
      t.string :last_name,  null: false
      t.date   :birthday,   null: false
      t.string :college
      t.string :hometown
      t.string :current_town
      t.string :telephone
      t.text   :words_to_live_by
      t.text   :about_me
      t.string :gender

      t.timestamps
    end
  end
end
