class UserPolicy < ApplicationPolicy

  def edit?
    # only allow the current_user to edit their own profile
    record.id == user.id
  end

  def update?
    # only allow the current_user to edit/update their own profile
    record.id == user.id
  end

  def destroy?
    # only allow the current_user to delete their own profile
    record.id == user.id
  end

end
