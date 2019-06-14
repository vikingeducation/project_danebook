class AddIndexToLikes < ActiveRecord::Migration[5.0]
  def change
    remove_index :likes, name: :index_likes_on_likeable_type_and_likeable_id
    remove_index :likes, name: :index_likes_on_user_id

    add_index :likes,
              [:user_id, :likeable_type, :likeable_id],
              { unique: true, name: 'index_likes_on_user_id_likeable_id_likeable_type'}
  end

end
