class AddNumberOfLikesToLikeables < ActiveRecord::Migration
  def change
    add_column :comments, :number_of_likes, :integer,
                default: 0,
                null: false

    add_column :posts, :number_of_likes, :integer,
                default: 0,
                null: false

    add_column :photos, :number_of_likes, :integer,
                default: 0,
                null: false
  end
end
