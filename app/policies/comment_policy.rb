class CommentPolicy < ApplicationPolicy

  def destroy?
    # only allow users to destroy their own comments
    record.user_id == user.id
  end

end
