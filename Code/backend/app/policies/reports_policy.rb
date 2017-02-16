class ReportsPolicy < ApplicationPolicy
  def show?
    admin? || support_agent?
  end
end
