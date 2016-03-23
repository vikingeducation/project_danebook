class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date   :birthdate
      t.string :college
      t.string :domicile
      t.string :hometown
      t.string :phone
      t.text   :my_words
      t.text   :about_me
      t.timestamps null: false
    end
  end
end
