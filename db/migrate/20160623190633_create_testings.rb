class CreateTestings < ActiveRecord::Migration
  def change
    create_table :testings do |t|
      t.string :name
      t.string :forest

      t.timestamps null: false
    end
    add_index :testings, :forest
  end
end
