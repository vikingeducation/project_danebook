class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :auth_token, unique: true, index: true

      t.timestamps null: false
    end
  end
end
