class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :post_id #post_id
      t.integer :like_count, default: 0
      t.timestamps
    end
  end
end
