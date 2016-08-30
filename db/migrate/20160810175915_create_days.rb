class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.references :profile_date, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
