class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :month
      t.integer :year
      t.integer :day
      t.string :college
      t.string :hometown
      t.string :current_location
      t.string :telephone
      t.timestamps
    end
  end
end
