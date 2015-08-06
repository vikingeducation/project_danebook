class ChangeCommentableTypeToString < ActiveRecord::Migration
  def change
  	change_column :comments, :commentable_type, :string
  end
end
