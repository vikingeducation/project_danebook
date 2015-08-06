class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 23
      t.string :last_name, null: false, limit: 23
      t.string :email, null: false, limit: 40
      t.text :password_digest, null: false, limit: nil

      t.timestamps null: false
    end
  end
end
