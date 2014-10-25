class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true
      t.string :fname, null: false
      t.string :lname, null: false
      t.string :password_digest, null: false
			t.string :auth_token, unique: true

      t.timestamps
    end
  end
end
