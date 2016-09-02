class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :auth_token

      t.timestamps
    end
    add_index :users, [:email, :auth_token], :unique => true
  end
end
