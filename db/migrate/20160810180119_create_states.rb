class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.references :address, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
