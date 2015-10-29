class AddPolymorphToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :liked_type, :string, :null => false
  end
end
