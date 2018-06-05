class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
