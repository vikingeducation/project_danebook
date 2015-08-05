class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.datetime :birthdate, :null => false
      t.string :gender
      t.integer :user_id, :null => false

      t.timestamps null: false
    end
  end
end
