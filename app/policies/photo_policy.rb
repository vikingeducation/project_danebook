class PhotoPolicy < ApplicationPolicy

  def create?
    # allow only if the current_user on their own timeline
    record.user_id == user.id
  end

  def destroy?
    # allow only if the current_user is on their own timeline
    record.user_id == user.id
  end

  def edit?
    # allow only if the current_user is viewing their own photo
    record.user_id == user.id
  end
end
