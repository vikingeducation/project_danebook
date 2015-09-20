class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer    :author_id, null: false
      t.text       :content, null: false
      t.references :commentable, polymorphic: true, null: false
      t.integer    :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
