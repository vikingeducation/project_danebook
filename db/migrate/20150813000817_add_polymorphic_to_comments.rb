class AddPolymorphicToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.remove :post_id
    end

  add_index :comments, [:commentable_type, :commentable_id], unique: true
  end
end
