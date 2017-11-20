class RemoveIndexOnLikes < ActiveRecord::Migration[5.0]
  def change
    remove_index(:likes, :name => 'index_likes_on_likeable_id_and_likeable_type') 
  end
end
