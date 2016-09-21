class Like < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id
  belongs_to :likeable, :polymorphic => true



  private 

  def self.find_likable_type(path)
    array = path.split("/")
    if array[1] == "comments"
      return "Comment"
    elsif array[1] == "posts"
      return "Post"
    end
  end

  
end
