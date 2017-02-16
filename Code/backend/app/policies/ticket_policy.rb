class TicketPolicy < ApplicationPolicy
  def index?
    admin? || support_agent? || customer?
  end

  def unfiltered_search?
    admin? || support_agent?
  end

  def show?
    admin? || support_agent? || own_request?
  end

  def reply?
    (admin? || support_agent? || own_request?) && !@record.closed?
  end

  def reopen?
    admin? || support_agent?
  end

  def close?
    admin? || support_agent?
  end

  def create?
    customer?
  end

  def update?
    admin? || support_agent? || own_request?
  end

  def destroy?
    admin?
  end

  private

  def own_request?
    @record.user_id&.eql?(@user.id)
  end
end
