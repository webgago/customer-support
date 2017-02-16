class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  def customer?
    @user&.customer?
  end

  def support_agent?
    @user&.support_agent?
  end

  def admin?
    @user&.admin?
  end
end
