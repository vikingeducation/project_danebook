class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :addressable, index: true, polymorphic: true
      t.string :address_1
      t.string :address_2

      t.timestamps null: false
    end
  end
end
