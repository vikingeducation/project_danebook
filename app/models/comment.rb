class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true

  belongs_to :author, foreign_key: "author_id",
                      class_name: "User"

end
