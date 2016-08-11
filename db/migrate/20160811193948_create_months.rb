class CreateMonths < ActiveRecord::Migration[5.0]
  def change
    create_table :months do |t|
      t.integer :month
      t.timestamps
    end
  end
end
