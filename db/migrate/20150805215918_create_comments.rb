class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false, default: ''
      t.references :user
      t.string :commentable_type
      t.integer :commentable_id

      t.timestamps null: false
    end
  end
end
