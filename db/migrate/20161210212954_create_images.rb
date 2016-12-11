class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.references :gallery, foreign_key: true
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
