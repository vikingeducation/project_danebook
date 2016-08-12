class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user, index: true, foreign_key: true
      t.references :commentable, polymorphic: true

      t.timestamps null: false
    end
    add_index :comments, [:commentable_type, :commentable_id] 
  end
end
