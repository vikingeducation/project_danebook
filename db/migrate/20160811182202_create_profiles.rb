class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :month
      t.integer :day
      t.integer :year
      t.string :gender

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
