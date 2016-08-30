class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.references :profile_date, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
