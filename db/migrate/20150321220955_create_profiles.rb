class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :birthday
      t.string :hometown
      t.string :currenttown
      t.string :email
      t.string :telephone
      t.text :words
      t.text :aboutme

      t.timestamps
    end
  end
end
