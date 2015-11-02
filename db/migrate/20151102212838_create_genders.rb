class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.string :name
      t.string :short_name, :limit => 32

      t.index :name
      t.index :short_name

      t.timestamps null: false
    end
  end
end
