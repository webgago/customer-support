# Base class for Managers
# Managers are Plain Ruby classes that implement business logic
# it can accept +current_user+ in initializer
# and provides +with_transaction+ helper
# any error should raise ApplicationError with corresponding message
# it will be thrown to end user
# also any AR methods should be used with bang (update!, create!, destroy!)
class ApplicationManager
  # @param [User] current_user
  def initialize(current_user = nil)
    @current_user = current_user
  end

  private

  def with_transaction
    result = nil
    ActiveRecord::Base.transaction do
      result = yield
    end
    result
  end
end
