class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :gender

      t.date :birthday
      t.string :college
      t.string :from
      t.string :lives
      t.string :number
      t.string :words
      t.string :about

      t.index :user_id, unique: true

      t.timestamps null: false
    end
  end
end
