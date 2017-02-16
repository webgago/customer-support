module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ApplicationError, with: :application_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from ActiveRecord::RecordInvalid, with: :active_model_error
    rescue_from ActiveRecord::RecordNotDestroyed, with: :active_model_error
  end

  def route_not_found
    skip_authorization
    render json: { errors: { base: ['Not Found'] } }, status: :not_found
  end

  private

  def application_error(exception)
    render_error exception, :unprocessable_entity
  end

  def active_model_error(exception)
    record_errors = exception.record.errors
    render json: { errors: record_errors }, status: :unprocessable_entity
  end

  def not_found(exception)
    render_error exception, :not_found
  end

  def parameter_missing(exception)
    render_error exception, :unprocessable_entity
  end

  def render_error(exception, status)
    render json: { errors: { base: Array.wrap(exception.message) } }, status: status
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    default_error_message = I18n.t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    error_status = current_user ? 403 : 401
    @errors = { base: [default_error_message] }
    record_errors = exception.record.try(:errors)
    unless record_errors.blank?
      @errors = record_errors
      error_status = 422
    end
    render json: { errors: @errors }, status: error_status
  end
end
