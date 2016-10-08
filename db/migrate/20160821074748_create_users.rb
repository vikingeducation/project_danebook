class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.date :birth_date
      t.string :auth_token
      t.integer :profile_pic_id
      t.integer :cover_pic_id

      t.timestamps
    end
    add_index :users, :auth_token, :unique => true
  end
end
