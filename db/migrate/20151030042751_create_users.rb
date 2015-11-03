class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :gender_id

      t.index :email, :unique => true
      t.index :auth_token, :unique => true
      t.index :first_name
      t.index :last_name
      t.index :birthday
      t.index :gender_id

      t.timestamps null: false
    end
  end
end
