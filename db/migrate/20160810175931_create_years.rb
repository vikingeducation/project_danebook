class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.references :profile_date, index: true, foreign_key: true
      t.integer :number

      t.timestamps null: false
    end
  end
end
