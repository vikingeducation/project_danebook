class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :words
      t.string :about

      t.timestamps null: false
    end
  end
end
