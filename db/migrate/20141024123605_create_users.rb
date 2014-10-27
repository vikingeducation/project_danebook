class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.integer :birth_month
      t.integer :birth_day
      t.integer :birth_year
      t.string :password_digest

      t.timestamps
    end
  end
end
