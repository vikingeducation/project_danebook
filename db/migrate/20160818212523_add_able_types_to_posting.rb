class AddAbleTypesToPosting < ActiveRecord::Migration
  def change
    add_column :postings, :user_id, :integer
    add_column :postings, :postable_type, :string
    add_column :postings, :postable_id, :integer
    add_attachment :photos, :file
    add_column :photos, :user_id, :integer
    add_column :likes, :photo_id, :integer
    add_column :comments, :photo_id, :integer
  end
end
