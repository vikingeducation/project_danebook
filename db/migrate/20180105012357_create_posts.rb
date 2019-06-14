class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.text :body, null: false, default: ""

      t.timestamps
    end
  end
end
