class CreatePostTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :post_texts do |t|
      t.integer :post_id
      t.text :body
      t.timestamps
    end
  end
end
