module UserAuth
  extend ActiveSupport::Concern

  class_methods do
    def from_token_request(request)
      email = request.params.fetch('email')
      return unless email.present?

      User.find_by(email: email) || raise(ApplicationError, 'Invalid login credentials. Please try again.')
    end

    def from_token_payload(claims)
      find claims['sub']
    end
  end

  def to_token_payload
    attributes.slice('email', 'last_name', 'first_name', 'role').update(sub: id, full_name: name)
  end

  def jwt_token
    Knock::AuthToken.new(payload: to_token_payload).token
  end
end
