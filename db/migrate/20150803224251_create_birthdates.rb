class CreateBirthdates < ActiveRecord::Migration
  def change
    create_table :birthdates do |t|

      t.integer :month
      t.integer :day
      t.integer :year

      t.timestamps null: false
    end
  end
end
