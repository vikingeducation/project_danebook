class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthday, null: false
      t.string :gender, null: false

      t.text :motto
      t.text :about

      t.string :college
      t.string :hometown
      t.string :residing

      t.string :phone

      t.references :user

      t.timestamps
    end
  end
end
