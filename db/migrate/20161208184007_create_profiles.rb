class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :gender

      t.references :user

      t.timestamps
    end
  end
end
