class AddPhotoIdFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_pic_id, :integer, foreign_key: true
    add_column :users, :cover_pic_id, :integer, foreign_key: true
  end
end
