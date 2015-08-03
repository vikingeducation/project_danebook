class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.integer :gender, null: false
      t.datetime :dob, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :auth_token

      t.timestamps null: false
    end
    add_index :users, :auth_token, :unique => true
  end
end
