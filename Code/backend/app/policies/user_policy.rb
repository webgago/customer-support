class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def create?
    admin? || !@user
  end

  def destroy?
    admin? && @user.id != @record.id
  end
end
