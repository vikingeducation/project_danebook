class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :user
      t.text :body
      t.timestamps null: false
    end
  end
end
