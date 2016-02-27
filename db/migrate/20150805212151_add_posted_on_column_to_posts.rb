class AddPostedOnColumnToPosts < ActiveRecord::Migration
  def change
    drop_table :posts

    create_table :posts do |t|
      t.text    :body, null: false
      t.integer :author_id, null: false
      t.integer :recipient_user_id, null: false

      t.timestamps null: false
    end
  end
end
