class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :first
      t.string :last
      t.date :birthday
      t.string :gender

      t.timestamps
    end
  end
end
