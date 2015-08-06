class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false, default: ''
      t.references :user
      t.references :post

      t.timestamps null: false
    end
  end
end
