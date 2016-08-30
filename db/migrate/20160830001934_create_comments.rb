class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :commenter_id

      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
    change_column :comments, :commentable_id, :integer, :null => false
    change_column :comments, :commenter_id, :integer, :null => false
  end
end
