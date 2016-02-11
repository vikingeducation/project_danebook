class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :birth_day
      t.integer :birth_month
      t.integer :birth_year
      t.string :gender
      
      t.timestamps null: false
    end
  end
end
