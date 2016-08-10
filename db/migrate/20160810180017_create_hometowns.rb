class CreateHometowns < ActiveRecord::Migration
  def change
    create_table :hometowns do |t|
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
