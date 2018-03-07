class PostPolicy < ApplicationPolicy

  # Allow these actions only if...

  def create?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  def edit?
    record.user_id == user.id
  end

end
