class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :college
      t.string :hometown
      t.string :location

      t.string :telephone
      t.text :words
      t.text :about

      t.timestamps null: false
    end
  end
end
