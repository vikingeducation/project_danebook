class CreateBios < ActiveRecord::Migration[5.0]
  def change
    create_table :bios do |t|
      t.references :profile
      t.string :slogan
      t.text :about

      t.timestamps
    end
  end
end
