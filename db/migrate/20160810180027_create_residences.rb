class CreateResidences < ActiveRecord::Migration
  def change
    create_table :residences do |t|
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
