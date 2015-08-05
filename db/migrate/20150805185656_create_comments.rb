class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.string :body
      t.integer :commenting_id
      t.integer :commenting_type

      t.timestamps null: false
    end

    add_index :comments, [:commenting_type, :commenting_id]
  end

end
