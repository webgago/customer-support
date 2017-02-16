module Authorization
  extend ActiveSupport::Concern
  include Pundit

  included do
    after_action :verify_authorized
  end
end
