class CreatePostings < ActiveRecord::Migration[5.0]
  def change
    create_table :postings do |t|
      t.integer "user_id"
      t.timestamps
    end
    add_reference :postings, :postable, polymorphic: true, index: true
  end
end
